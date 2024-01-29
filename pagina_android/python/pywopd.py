from docxtpl import DocxTemplate
from decimal import Decimal
from docx import Document
import os
import subprocess

def conv(tc,e,m):
    tcl = [list(tupla) for tupla in tc]
    ml = [list(tupla) for tupla in m]
    el = [list(tupla) for tupla in e]
    for i in range(len(tcl)):
        for j in range(len(tcl[i])):
            if tcl[i][j] is None:
                tcl[i][j] = ""
    for i in range(len(ml)):
        for j in range(len(ml[i])):
            if ml[i][j] is None:
                ml[i][j] = ""
    for i in range(len(el)):
        for j in range(len(el[i])):
            if el[i][j] is None:
                el[i][j] = ""
    tcl = [[int(float(str(elemento))) if isinstance(elemento, Decimal) else elemento for elemento in sublista] for sublista in tcl]
    el = [[int(float(str(elemento))) if isinstance(elemento, Decimal) else elemento for elemento in sublista] for sublista in el]
    datosC = tcl+ml+el
    return datosC

def genboletadocx(datosC, datosG):
    doc = DocxTemplate(os.path.expanduser('~/DGTIPOCKET/editar_word/plantilla_boleta_mamalona.docx'))

    nombre=datosG[3][0]+" "+datosG[3][1]

    control = datosG[0].replace("@cetis155.edu.mx","")
    gen = control[0]+control[1]
    nombr = ""
    for i in range(len(datosG[3])):
        nombr = nombr +datosG[3][i]+" "
    
    context = { 
        'control' : control,
        'nombre' : nombr,
        'semestre' : datosG[1][0],
        'carre' : datosG[4],
        'turno' : datosG[2],
        'grupo' : datosG[1],
        'gen' : "20"+gen+"-"+"20"+str(int(gen)+3),
        'boleta': datosC
    }
        
    doc.render(context)
    print(nombre)
    doc.save(os.path.expanduser('~/DGTIPOCKET/editar_word/'+nombre.replace(" ","_")+'.docx'))

def docx2pdf(input):
    command = ['abiword', '--to=pdf', input]

    try:
        subprocess.run(command, check=True)
        os.remove(input)
        print(f'Se ha convertido correctamente.')
    except subprocess.CalledProcessError as e:
        print(f'Error al convertir el archivo: {e}')