package com.web4edu.edulifepocketweb;

import android.Manifest;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.webkit.CookieManager;
import android.webkit.URLUtil;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import android.app.DownloadManager;
import android.net.Uri;
import android.os.Environment;
import android.webkit.DownloadListener;

import android.util.Log;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity {
    private WebView myWebView;
    private WebSettings myWebSettings;
    private static final String TAG="AndroidRide";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myWebView = findViewById(R.id.web1);
        myWebSettings = myWebView.getSettings();
        myWebSettings.setUserAgentString("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3");
        myWebSettings.setJavaScriptEnabled(true);
        myWebSettings.setDomStorageEnabled(true);
        myWebView.setWebViewClient(new WebViewClient());
        myWebView.setDownloadListener(new DownloadListener() {
            @Override
            public void onDownloadStart(final String url, final String userAgent, String contentDisposition, String mimetype, long contentLength)
            {

                /*if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    // Utiliza MediaStore para Android 10 y versiones posteriores.
                    if (ContextCompat.checkSelfPermission(MainActivity.this, android.Manifest.permission.MANAGE_EXTERNAL_STORAGE)
                            == PackageManager.PERMISSION_GRANTED) {
                        Log.v(TAG,"Permission is granted (MANAGE)");
                        downloadUsingMediaStore(url, userAgent, contentDisposition, mimetype);
                    }else {
                        Log.v(TAG,"Permission is revoked (MANAGE)");
                        // El permiso no está concedido. Solicítalo al usuario.
                        ActivityCompat.requestPermissions(MainActivity.this, new String[]{android.Manifest.permission.MANAGE_EXTERNAL_STORAGE},101);
                        Log.v(TAG, "After requesting permission (MANAGE)");
                    }
                } else */if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
                        Log.v(TAG,"Permission is granted (WRITE)");
                        downloadDialog(url,userAgent,contentDisposition,mimetype, contentLength);
                    } else {
                        Log.v(TAG,"Permission is revoked (WRITE)");
                        ActivityCompat.requestPermissions(MainActivity.this, new String[]{android.Manifest.permission.WRITE_EXTERNAL_STORAGE}, 100);
                        Log.v(TAG, "After requesting permission (WRITE)");
                    }
                }
                else {
                    //Code for devices below API 23 or Marshmallow
                    Log.v(TAG,"Permission is granted");
                    downloadDialog(url,userAgent,contentDisposition,mimetype, contentLength);
                }
            }
        });
        myWebView.loadUrl("https://patotipo.pythonanywhere.com/");
    }
    public void downloadDialog(final String url,final String userAgent,String contentDisposition,String mimetype, long contentLength)
    {
        //getting filename from url.
        String filename = URLUtil.guessFileName(url,contentDisposition,mimetype);
        Log.v(TAG,"Archivo a descargar: "+filename);
        //alertdialog
        DownloadManager downloadManager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));

        request.addRequestHeader("User-agent", userAgent);
        request.addRequestHeader("Cookie", CookieManager.getInstance().getCookie(url));
        request.setTitle(filename);
        request.setDescription("Downloading...");
        request.setMimeType(mimetype);
        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, filename);
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE | DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);

        try{
            downloadManager.enqueue(request);
            Toast.makeText(MainActivity.this, "Download started!", Toast.LENGTH_SHORT).show();
        }catch (Exception e){
            Toast.makeText(MainActivity.this, e.toString(), Toast.LENGTH_LONG).show();
        }
    }
    /*private void downloadUsingMediaStore(String url, String userAgent, String contentDisposition, String mimetype) {
        // Obtiene el nombre del archivo desde la URL.
        String filename = URLUtil.guessFileName(url, contentDisposition, mimetype);
        Log.v(TAG,"Archivo a descargar: "+filename);
        // Crea un nuevo objeto ContentValues.
        ContentValues contentValues = new ContentValues();
        contentValues.put(MediaStore.Downloads.TITLE, filename);
        contentValues.put(MediaStore.Downloads.DISPLAY_NAME, filename);
        contentValues.put(MediaStore.Downloads.MIME_TYPE, mimetype);

        // Configura la ruta de destino en el directorio de descargas.
        contentValues.put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);

        // Obtiene el ContentResolver.
        ContentResolver contentResolver = getContentResolver();

        // Inserta el archivo en MediaStore.
        Uri uri = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
            uri = contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues);
        }

        // Crea un intent para descargar el archivo.
        DownloadManager downloadManager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));
        request.addRequestHeader("User-agent", userAgent);
        request.addRequestHeader("Cookie", CookieManager.getInstance().getCookie(url));
        request.setDestinationUri(uri);

        // Enqueue la solicitud de descarga.
        try {
            downloadManager.enqueue(request);
            Toast.makeText(MainActivity.this, "Download started!", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(MainActivity.this, e.toString(), Toast.LENGTH_LONG).show();
        }
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        // Verifica si el requestCode corresponde al que usaste al solicitar el permiso.
        if (requestCode == 101) {
            // Verifica si se otorgaron permisos.
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // El usuario otorgó el permiso. Puedes realizar acciones relacionadas con el permiso aquí.
                Log.d(TAG, "Permission granted! :)");
                // Puedes, por ejemplo, llamar a la función que realiza la descarga aquí.
                // downloadUsingMediaStore(url, userAgent, contentDisposition, mimetype);
            } else {
                // El usuario denegó el permiso. Puedes mostrar un mensaje o tomar alguna acción adicional.
                Log.d(TAG, "Permission denied! :(");
                Toast.makeText(this, "Permission denied. Cannot download.", Toast.LENGTH_SHORT).show();
            }
        } else {
            // Este bloque puede ser necesario si tu actividad maneja múltiples solicitudes de permisos.
            // Puedes manejar otros requestCode aquí si es necesario.
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }*/
    @Override
    public void onBackPressed(){
        if (myWebView.canGoBack()){
            myWebView.goBack();
        }else{
            super.onBackPressed();
        }
    }

}