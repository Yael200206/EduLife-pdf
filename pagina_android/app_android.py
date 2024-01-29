from flask import Flask, render_template,redirect,url_for, request, session, send_file
from authlib.integrations.flask_client import OAuth
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import Flow
from googleapiclient.discovery import build
from google.auth.transport.requests import Request
from googleapiclient.errors import HttpError
import google.auth.exceptions
import os
import os.path
from python.bd import *
from python.pywopd import *
import datetime
import json
import matplotlib.pyplot as plt

from io import BytesIO
import base64
from bs4 import BeautifulSoup

from python.funciones_auth import login_required

from dotenv import load_dotenv

project_folder = os.path.expanduser('~/DGTIPOCKET/pagina_android')
load_dotenv(os.path.join(project_folder, '.env'))

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.expanduser('~/DGTIPOCKET/editar_word')
app.config['ALLOWED_EXTENSIONS'] = {'pdf', 'xls', 'xlsx'}
app.secret_key = os.getenv("APP_SECRET_KEY")

oauth = OAuth(app)

google = oauth.register(
    name='google',
    client_id= os.getenv("GOOGLE_CLIENT_ID"),
    client_secret= os.getenv("GOOGLE_CLIENT_SECRET"),
    authorize_url='https://accounts.google.com/o/oauth2/auth',#auth_url,
    # authorize_params=None,
    # authorize_callback=None,
    # authorize_response=None,
    token_url='https://oauth2.googleapis.com/token',
    # token_params=None,
    # token_response=None,
    api_base_url='https://www.googleapis.com/oauth2/v1/',
    #--userinfo_endpoint='https://openidconnect.googleapis.com/v1/userinfo',  # This is only needed if using openId to fetch user info
    server_metadata_url='https://accounts.google.com/.well-known/openid-configuration',
    client_kwargs={'scope': 'openid email profile https://www.googleapis.com/auth/calendar.readonly'},
)

@app.route('/')
@login_required
def index():
    bd = Coneccion()
    noticias = bd.obtenerTablas("noticias")
    avisos = bd.obtenerTablas("avisos")
    concursos = bd.obtenerTablas("concursos")
    bd.exit()
    #print("---------------sesion")
    #print(dict(session))
    parametros = dict(session)['profile']
    toks = dict(session)['tok_info']

    #print("session token")
    #print(toks)

    if parametros['persona'] == 'maestro':
        return render_template('autoridades/funcionesMaestros.html', parametros=parametros, noticias=noticias, avisos=avisos)
    elif parametros['persona'] == 'programador':
        return render_template('autoridades/indexP.html', parametros = parametros,noticias=noticias, avisos=avisos, concursos=concursos)
    else:
        return render_template('indexapp.html', parametros = parametros,noticias=noticias, avisos=avisos, concursos=concursos)

###         INISIO DE SESION        ###

@app.route('/carga')
def carga():
    return render_template("intro.html")

@app.route('/login')
def login():
    google = oauth.create_client('google')  # create the google oauth client
    return google.authorize_redirect(url_for('authorize', _external=True), access_type='offline', prompt='consent')

@app.route('/authorize')
def authorize():
    google = oauth.create_client('google')  # create the google oauth client
    token = google.authorize_access_token()  # Access token from google (needed to get user info)
    tokens = {'client_id':os.getenv("GOOGLE_CLIENT_ID"),'client_secret': os.getenv("GOOGLE_CLIENT_SECRET"), 'token_uri': 'https://oauth2.googleapis.com/token'}
    # tokens = {
    #     'token': token['access_token'],
    #     'refresh_token': 'your_refresh_token',
    #     'token_uri': 'https://oauth2.googleapis.com/token',
    #     'client_id': os.getenv("GOOGLE_CLIENT_ID"),
    #     'client_secret': os.getenv("GOOGLE_CLIENT_SECRET"),
    #     'scopes': token['scope'].split(),
    #     'expiry': 'expiry_timestamp',
    #     'id_token': token['id_token'],
    # }
    resp = google.get('userinfo')  # userinfo contains stuff u specificed in the scrope
    user_info = resp.json()
    token.pop('userinfo')
    tokens.update(token)
    session['tok_info'] = tokens
    #print("---------------toks")
    #print(tokens)
    with open("token.txt", "w") as tok:
        tok.write(str(tokens))
    #print("fin")
    #session.permanent = True  # make the session permanant so it keeps existing after broweser gets closed
    if str.isnumeric(user_info['email'][0]):
        user_info.update({'persona':'alumno'})
        session['profile'] = user_info
        return redirect('/terminar')
    
    else:
        user_info.update({'persona':'maestro'})
        session['profile'] = user_info
        return redirect('/m')

###         PRIMER REGISTRO DE SESION       ###

@app.route('/terminar')
@login_required
def terinar():
    parametros = dict(session)['profile']
    bd = Coneccion()
    no = parametros['email'].replace("@cetis155.edu.mx","")
    curp =  bd.seleccion("alumnos", "curp","no_control = "+str(no))
    grado =  bd.seleccion("alumnos", "grado","no_control = "+str(no))
    bd.exit()
    
    if len(grado)>0 and len(curp)>0:
        bd = Coneccion()
        grupo = bd.seleccion("grupo","letra","idgrupo = "+str(bd.seleccion("alumnos","grupo_idgrupo","no_control = "+str(no))[0][0]))[0][0]
        bd.exit()
        print(grupo)
        parametros.update({'curp': curp[0][0],'grado':grado[0][0], 'grupo':grupo})
        session['profile'] = parametros
        return redirect(url_for("index"))  
    return render_template('inisioSesion/terminarR.html', parametros = parametros)

@app.route('/insertainfo', methods=['GET', 'POST'])
@login_required
def insertainfo():
    parametros = dict(session)['profile']
    if request.method == 'POST':
        datos = []
        bd = Coneccion()
        no = parametros['email'].replace("@cetis155.edu.mx","")
        datos.append(no)
        datos.append(request.form['curp'])
        datos.append(request.form['grado'])
        datos.append(str(bd.seleccion("grupo","idgrupo","letra = '"+str(request.form['grupo'])+"'")[0][0]))
        bd.insertarRegistro("alumnos",datos)
        bd.exit()
        parametros.update({'curp':datos[1],'grado':datos[2], 'grupo':request.form['grupo']})
        session['profile'] = parametros
        return redirect(url_for("index"))

    return redirect(url_for("index"))

###     CIERRE DE SESION        ###

@app.route('/logout')
def logout():
    for key in list(session.keys()):
        session.pop(key)
    return redirect(url_for('carga'))

###         FUNCIONES DE SESION         ###

@app.route('/config')
def config():
    parametros = dict(session)['profile']
    return render_template('inisioSesion/config.html', parametros = parametros)

@app.route('/menu')
def menu():
    parametros = dict(session)['profile']
    return render_template('inisioSesion/menu.html', parametros = parametros)

@app.route('/funciones')
def funciones():
    parametros = dict(session)['profile']
    return render_template('inisioSesion/funcionesapp.html', parametros = parametros)

###         FUNCIONES SIMPLES       ###

@app.route('/agenda')
def agenda():
    parametros = dict(session)['profile']
    horario = str(parametros['grado']) + str(parametros['grupo']) 
    print("------------------")
    print(horario)
    return render_template('funciones/agenda.html', parametros = parametros,archivo=horario)

@app.route('/cuadernillo')
def cuadernillo():
    parametros = dict(session)['profile']
    return render_template('funciones/cuadernillo.html', parametros = parametros)

@app.route('/pagos')
def pagos():
    parametros = dict(session)['profile']
    return render_template('funciones/pagos.html', parametros = parametros)

@app.route('/servicio')
def servicio():
    parametros = dict(session)['profile']
    return render_template('funciones/servicio.html', parametros = parametros)

@app.route('/historial')
def historial():
    plot_url = generate_plot()
    parametros = dict(session)['profile']
    return render_template('funciones/historial.html', parametros = parametros,plot_url=plot_url)

@app.route('/actualizar_info', methods = ['POST', 'GET'])
def actualizar():
    parametros = dict(session)['profile']
    db = Coneccion()
    datos = db.seleccion("alumnos","*","no_control = '"+parametros['email'].replace("@cetis155.edu.mx","")+"'")[0]
    print(datos)
    db.exit
    if request.method == 'POST':
        for i in range(3):
            datos[i+2] = request.form['A'+str(i)]
        db = Coneccion()
        db.actualizarRegistro("alumnos",datos[0],datos[1:])
        db.exit
        return redirect(url_for("logout"))
    db = Coneccion()
    grupos = db.seleccion("grupo","idgrupo, letra","true")
    db.exit()
    return render_template('inisioSesion/cambio.html', parametros=parametros, grupos = grupos)
    


#######################################################################################
@app.route('/planteles')                                                              #
def planteles1():                                                                     #
    parametros = dict(session)['profile']                                             #
    return render_template('funciones/plantelesapp.html', parametros = parametros)    #
                                                                                      #
@app.route('/organigrama')                                                            #
def organigrama():                                                                    #
    parametros = dict(session)['profile']                                             #
    return render_template('funciones/organigrama.html', parametros = parametros)     #
#######################################################################################

###         FUNCIONES DETALLADAS        ###

@app.route('/boleta')
def boleta():
    parametros = dict(session)['profile']
    nombre = parametros["name"]
    if "�" in nombre:
        nombre = nombre.replace("�","Ñ")
    nom = nombre.split(" ")
    nombr = []
    nombr.append(nom[-2])
    nombr.append(nom[-1])
    if len(nom) == 4:
        nombr.append(nom[-4])
        nombr.append(nom[-3])
    else:
        nombr.append(nom[-3])

    bd = Coneccion()

    turesp = bd.llamar("turesp({0})".format(parametros["email"].replace("@cetis155.edu.mx","")))

    datosG = [parametros["email"],parametros["grado"]+parametros["grupo"],turesp[0][0],nombr,turesp[0][1]]

    ida = bd.seleccion("alumnos","idalumnos","no_control = {0}".format(parametros["email"].replace("@cetis155.edu.mx","")))

    tc = bd.llamar("boleta_tc({0})".format(ida[0][0]))
    m = bd.llamar("boleta_m({0})".format(ida[0][0]))
    e = bd.llamar("boleta_e({0})".format(ida[0][0]))

    bd.exit()

    datosC = conv(tc,e,m)

    genboletadocx(datosC, datosG)
    word = os.path.expanduser('~/DGTIPOCKET/editar_word/'+nombr[0]+"_"+nombr[1]+'.docx')
    docx2pdf(word)
    pdf = os.path.expanduser('~/DGTIPOCKET/editar_word/'+nombr[0]+"_"+nombr[1]+'.pdf')
    
    try:
        return send_file(pdf, as_attachment=True)
    finally:
        if os.path.exists(pdf):
            os.remove(pdf)
            print(f'Archivo {pdf} eliminado correctamente.')

@app.route('/tabla/<string:table>')
def tabla(table):
    parametros = dict(session)['profile']
    bd = Coneccion()
    atributos = bd.obtenerAtributos(table)
    datos = bd.obtenerTablas(table)
    tab2 = ""

    if "_id" in atributos[-1]:
        for a in atributos[-1]:
            if a != "_":
                tab2 += a
            else:
                break

        atributos.pop(-1)
        atributos.append(tab2)

        for dato in datos:
            dato.append(bd.seleccion(tab2, "nombre", "id"+str(tab2)+"="+str(dato[-1]))[0][0])
            dato.pop(-2)
    bd.exit()
    return render_template('autoridades/funcionesAut/tabla.html', parametros = parametros, atributos = atributos, datos = datos, table = table)

@app.route('/clubs')
def clubs():
    parametros = dict(session)['profile']
    bd = Coneccion()
    clubs = bd.obtenerTablas("clubs")
    bd.exit()
    return render_template('funciones/clubapp.html', parametros = parametros, clubs=clubs)

@app.route('/tutorias')
def tutorias():
    parametros = dict(session)['profile']
    bd = Coneccion()
    tut = bd.obtenerTablas("tutorias")
    tuto = []
    for i in tut:
        tuto.append([])
        for j in tut:
            if str(j).isdigit():
                tuto.append(bd.seleccion("materias","nombre","idmaterias = "+str(j))[0][0])
            else:
                tuto.append(j)
    bd.exit()
    return render_template('funciones/tutoriasapp.html', parametros = parametros, tutorias = tuto)

@app.route('/noticias')                         #pendiente css
def noticias():
    bd = Coneccion()
    noticias = bd.obtenerTablas("noticias")
    bd.exit()
    parametros = dict(session)['profile']
    return render_template('funciones/noticiasapp.html', noticias=noticias, parametros = parametros)

####        AUTORIDADES         ####

@app.route('/m')
@login_required
def index_maestros():
    bd = Coneccion()
    noticias = bd.obtenerTablas("noticias")
    avisos = bd.obtenerTablas("avisos")
    concursos = bd.obtenerTablas("concursos")
    bd.exit()
    print("---------------sesion")
    print(dict(session))
    parametros = dict(session)['profile']
    toks = dict(session)['tok_info']

    print("session token")
    print(toks)
    
    #archivo = str(parametros['grado']) + str(parametros['grupo']) 

    return render_template('autoridades/indexMaestros.html', parametros = parametros,noticias=noticias, avisos=avisos, concursos=concursos)#,archivo=archivo)

@app.route('/p')#+++++++++++++++++++++++++++++++++++++++++++++++index programador algo bien 
@login_required
def index_Programadores():
    bd = Coneccion()
    noticias = bd.obtenerTablas("noticias")
    avisos = bd.obtenerTablas("avisos")
    concursos = bd.obtenerTablas("concursos")
    bd.exit()
    print("---------------sesion")
    print(dict(session))
    parametros = dict(session)['profile']
    toks = dict(session)['tok_info']

    print("session token")
    print(toks)
    
    #archivo = str(parametros['grado']) + str(parametros['grupo']) 

    return render_template('autoridades/indexP.html', parametros = parametros,noticias=noticias, avisos=avisos, concursos=concursos)#,archivo=archivo)

@app.route('/Mconfig')
def Mconfig():
    parametros = dict(session)['profile']
    return render_template('autoridades/configMaestros.html', parametros = parametros)

@app.route('/Mfunciones')
def Mfunciones():
    parametros = dict(session)['profile']
    return render_template('autoridades/funcionesMaestros.html', parametros = parametros)

@app.route('/insDat/<string:nom>', methods=['GET', 'POST']) ### INSERTAR NOTICIAS AVISOS CONCURSOS
def agregar_noticia(nom=None):
    parametros = dict(session)['profile']
    tab2 = ""
    comb = None
    bd = Coneccion()
    atr = bd.obtenerAtributos(nom)
    bd.exit()
    if request.method == 'POST':
        datos = []
        for i in range(len(atr)-1):
            print("obteniendo: A"+str(i))
            datos.append(request.form['A'+str(i)])
        bd = Coneccion()
        bd.insertarRegistro(nom, datos)
        bd.exit()
        if nom == "noticias" or nom == "avisos" or nom == "concursos":
            return render_template('autoridades/funcionesAut/insnot.html', parametros = parametros)
        else:
            return redirect(url_for('tabla', table = nom))
    if nom == "noticias" or nom == "avisos" or nom == "concursos":
        return render_template('autoridades/funcionesAut/insnot.html', parametros = parametros)
    else:
        if "_id" in atr[-1]:
            for a in atr[-1]:
                if a != "_":
                    tab2 += a
                else:
                    break

            atr.pop(-1)
            atr.append(tab2)

            bd = Coneccion()
            comb = bd.seleccion(tab2, "id"+tab2+",nombre", "true")
            bd.exit()
        
        return render_template('autoridades/funcionesAut/agred.html', parametros = parametros, atributos = atr, tabla= nom, comb=comb)

@app.route('/edDat/<string:tabla>/<string:ide>', methods=['POST', 'GET'])
def edDat(tabla, ide):
    parametros = dict(session)['profile']
    datos = []
    tab2 = ""
    comb = None
    bd = Coneccion()
    atr = bd.obtenerAtributos(tabla)
    bd.exit()
    if request.method == 'POST':
        for i in range(len(atr)-1):
            datos.append(request.form['A'+str(i)])
        bd = Coneccion()
        bd.actualizarRegistro(tabla,ide,datos)
        bd.exit()
        return redirect(url_for('tabla',table=tabla))
    bd = Coneccion()
    datos = bd.seleccion(tabla,"*","id"+str(tabla)+" = "+str(ide))
    bd.exit()
    if "_id" in atr[-1]:
        for a in atr[-1]:
            if a != "_":
                tab2 += a
            else:
                break

        atr.pop(-1)
        atr.append(tab2)

        bd = Coneccion()
        comb = bd.seleccion(tab2, "id"+tab2+",nombre", "true")
        bd.exit()
        datos[0].pop(-1)
        datos.append(comb[0][-1])
    return render_template('autoridades/funcionesAut/agred.html', parametros = parametros, atributos = atr, datos = datos, tabla = tabla, ide = ide, comb=comb)

@app.route("/delDat/<string:tabla>/<string:id>")
def delDat(tabla, id):
    bd = Coneccion()
    bd.eliminarRegistro(tabla, id)
    bd.exit()
    return redirect(url_for('tabla',table=tabla))

def extencion(arch):
    return '.' in arch and arch.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route("/subirCal", methods = ['POST', 'GET'])
def subibrCal():
    if request.method == 'POST':
        if 'file' not in request.files:
            return "No se encontro el archivo"

        file = request.files['file']

        if file.filename == '':
            return "Archivo no seleccionado"

        if file and extencion(file.filename):
            file.save(f"{app.config['UPLOAD_FOLDER']}/{file.filename}")
            return redirect(url_for("leerCal"), nombre = file.filename)
        else:
            return "Extension del archivo no permitida"
    return render_template("autoridades/funcionesAut/insCal.html")

def obtGrupo(grupo, esp, turno):
    if esp == "PROGRAMACIÓN":
        if turno == "matutino":
            return str(grupo[0])+"A"
        else:
            return str(grupo[0])+"G"
    elif esp == "SOPORTE Y MANTENIMIENTO DE EQUIPO DE CÓMPUTO":
        if turno == "matutino":
            return str(grupo[0])+"B"
        else:
            return str(grupo[0])+"H"
    elif esp == "ADMINISTRACIÓN DE RECURSOS HUMANOS":
        if turno == "matutino":
            if grupo[1] == "A":
                return str(grupo[0])+"C"
            elif grupo[1] == "B":
                return str(grupo[0])+"D"
            else:
                return str(grupo[0])+"E"
        else:
            if grupo[1] == "A":
                return str(grupo[0])+"I"
            elif grupo[1] == "B":
                return str(grupo[0])+"J"
            else:
                return str(grupo[0])+"K"
    elif esp == "MANTENIMIENTO AUTOMOTRIZ":
        if turno == "matutino":
            return str(grupo[0])+"F"
        else:
            return str(grupo[0])+"L"
    else:
        return grupo

@app.route("/leerCal/<string:nombre>")
def leerCal(nombre):
    # Cargar el archivo HTML
    ruta = os.path.expanduser('~/DGTIPOCKET/editar_word/'+nombre)
    with open(ruta, 'r', encoding='MacRoman') as archivo_html:
        contenido_html = archivo_html.read()

    # Crear un objeto BeautifulSoup
    soup = BeautifulSoup(contenido_html, 'html.parser')

    # Encontrar la tabla en el HTML
    tabla = soup.find('table')
    pri = True

    # Verificar si se encontró la tabla
    if tabla:
        # Iterar sobre las filas y columnas de la tabla
        db = Coneccion()
        for fila in tabla.find_all('tr'):
            # Obtener los datos de las celdas
            datos_celda = [celda.text.strip() for celda in fila.find_all(['th', 'td'])]
            if pri:
                if datos_celda != ['CLV_CENTRO', 'PLANTEL', 'CARRERA', 'GENERACION', 'TURNO', 'SEMESTRE', 'GRUPO', 'NO CONTROL', 'NOMBRE', 'PATERNO', 'MATERNO', 'CURP', 'NOMBRE ASIGNATURA', 'PARCIAL 1', 'PARCIAL 2', 'PARCIAL 3', 'CALIFICACION', 'PERIODO', 'FIRMADO', 'FIRMA', 'ASISTENCIAS 1', 'ASISTENCIAS 2', 'ASISTENCIAS 3', 'TOTAL ASISTENICIAS', 'TIPO ACREDITACION']:
                    return "Formato del excel no compatible"
            else:
                #print(datos_celda)
                caracteres = {"”": "Ó", "Õ": "Í", "¡": "Á", "…": "É", "⁄": "Ú", "—": "Ñ"}

                tabCam= str.maketrans(caracteres)

                datos_celda = [cadena.translate(tabCam) for cadena in datos_celda]
                datos_celda[6] = obtGrupo(datos_celda[6], datos_celda[2], datos_celda[4])
                #print(datos_celda[2],datos_celda[4],datos_celda[6],datos_celda[7],datos_celda[11],datos_celda[12],datos_celda[13],datos_celda[14],datos_celda[15],datos_celda[17],datos_celda[20],datos_celda[21],datos_celda[22],datos_celda[24])
                
                if not(len(db.seleccion("alumnos","*","no_control = '"+datos_celda[7]+"'")) > 0):
                    grupo = db.seleccion("grupo","idgrupo","letra = '"+datos_celda[6][1]+"'")[0][0]
                    datos = [datos_celda[7],datos_celda[11],datos_celda[6][0],str(grupo)]
                    db.insertarRegistro("alumnos", datos)
                    print(datos)
                else:
                    print("alumnos en la bd")

                idm = db.seleccion("materias","idmaterias","nombre = '"+datos_celda[12]+"'")
                mat = True
                if not(len(idm) > 0):
                    idm = db.seleccion("submodulos","idsubmodulos","nombre = '"+datos_celda[12]+"'")
                    mat = False
                    if not(len(idm) > 0):
                        mod = db.seleccion("modulos","idmodulos","nombre = '"+datos_celda[12]+"'")
                if (len(idm) > 0):
                    #al = db.seleccion("alumnos","idalumnos","no_control = '"+datos_celda[7]+"'")
                    al = 0
                    if (int(datos_celda[7][1]) <= 2 and len(idm) > 1) or len(idm) > 0:
                        idm = idm[0][0]
                    else:
                        idm = idm[0][1] 
                    datos = [datos_celda[13],datos_celda[14],datos_celda[15],datos_celda[20],datos_celda[21],datos_celda[22],
                            datos_celda[17],datos_celda[24],str(idm),str(al)]
                    pre = db.seleccion("evaluacion_tc","idevaluacion_tc","periodo = '{}' and acreditacion = '{}' and materias_idmaterias = '{}' and alumnos_idalumnos = '{}'".format(datos_celda[17],datos_celda[24],idm,al))
                    if len(pre) > 0:
                        db.actualizarRegistro("evaluacion_tc",str(pre[0][0]),datos)
                    else:
                        pre = db.seleccion("evaluacion_e","*","periodo = '{}' and acreditacion = '{}' and submodulos_idsubmodulos = '{}' and alumnos_idalumnos = '{}'".format(datos_celda[17],datos_celda[24],idm,al))
                        if len(pre) > 0:
                            db.actualizarRegistro("evaluacion_e",str(pre[0][0]),datos)
                        else:
                            if mat:
                                db.insertarRegistro("evaluacion_tc",datos)
                            else:
                                db.insertarRegistro("evaluacion_e",datos)
                elif len(mod) > 0:
                    print("modulo encontrado: ",datos_celda[12])
                else:
                    return "materia no encontrada: "+str(datos_celda[12])
            pri = False
        db.exit()
        if os.path.exists(ruta):
            os.remove(ruta)
            print(f'Archivo {ruta} eliminado correctamente.')
        return redirect(url_for("index_maestros"))
    else:
        print("No se encontró ninguna tabla en el xls.")

####            PRUEBAS             ####

@app.route('/a') ### ???? carlin epico papu
def a():
    parametros = dict(session)['profile']
    return render_template('pruebas/a.html', parametros = parametros)

@app.route('/a')
def pruebas():
    parametros = dict(session)['profile']
    return render_template('prueba.html', parametros = parametros)

def generate_plot():
    x = ['Fisica 2', 'CIENCIA, TECNOLOGÍA, SOCIEDAD Y VALORES', 'CÁLCULO INTEGRAL',
         'INGLÉS V', 'CONSTRUYE BASES DE DATOS PARA APLICACIONES WEB',
         'DESARROLLA APLICACIONES WEB CON CONEXIÓN A BASES DE DATOS']
    y = [5, 7, 9, 8, 10, 9]

    plt.bar(x, y, color='skyblue')
    plt.xlabel('Materias')
    plt.ylabel('Promedio')
    plt.title('Gráfico de Barras - Promedio')

    # Guardar el gráfico en un BytesIO para mostrarlo en la página HTML
    img = BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    plt.close()

    # Convertir la imagen a base64
    plot_url = base64.b64encode(img.getvalue()).decode()

    return plot_url

if __name__ == '__main__':
    app.run(debug=True, ssl_context='adhoc', threaded=True)
