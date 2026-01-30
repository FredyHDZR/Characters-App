package com.example.flutter_character_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Handler
import android.os.Looper
import android.widget.RemoteViews
import java.io.File
import java.io.FileOutputStream
import java.io.InputStream
import java.net.URL
import java.security.MessageDigest

class CharacterWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        updateWidget(context, appWidgetManager, appWidgetIds)
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(
            android.content.ComponentName(context, CharacterWidget::class.java)
        )
        updateWidget(context, appWidgetManager, appWidgetIds)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(
            android.content.ComponentName(context, CharacterWidget::class.java)
        )
        
        when (intent.action) {
            AppWidgetManager.ACTION_APPWIDGET_UPDATE,
            "dev.fluttercommunity.plus.home_widget.UPDATE_WIDGET",
            "android.appwidget.action.APPWIDGET_UPDATE" -> {
                Handler(Looper.getMainLooper()).postDelayed({
                    updateWidget(context, appWidgetManager, appWidgetIds)
                }, 200)
                Handler(Looper.getMainLooper()).postDelayed({
                    updateWidget(context, appWidgetManager, appWidgetIds)
                }, 1000)
            }
        }
    }

    private fun updateWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.character_widget)

            val appContext = context.applicationContext
            
            val possiblePrefsNames = listOf(
                "HomeWidgetPreferences",
                "dev.fluttercommunity.plus.home_widget",
                "HomeWidgetProvider",
                "home_widget",
                "flutter.home_widget"
            )
            
            var name = "Unknown"
            var imageUrl: String? = null
            
            for (prefsName in possiblePrefsNames) {
                try {
                    val prefs: SharedPreferences = appContext.getSharedPreferences(
                        prefsName,
                        Context.MODE_PRIVATE
                    )
                    
                    val allPrefs = prefs.all
                
                    if (allPrefs.isNotEmpty()) {
                        val readName = prefs.getString("name", null)
                        val readImage = prefs.getString("image", null)
                        
                        if (!readName.isNullOrEmpty() && name == "Unknown") {
                            name = readName
                        }
                        
                        if (!readImage.isNullOrEmpty() && imageUrl.isNullOrEmpty()) {
                            imageUrl = readImage
                        }
                        
                        if (name != "Unknown" && !imageUrl.isNullOrEmpty()) {
                            break
                        }
                        
                        if (name == "Unknown") {
                            for ((key, value) in allPrefs) {
                                if (key.contains("name", ignoreCase = true)) {
                                    val strValue = when (value) {
                                        is String -> value
                                        else -> value.toString()
                                    }
                                    if (strValue.isNotEmpty()) {
                                        name = strValue
                                        break
                                    }
                                }
                            }
                        }
                        
                        if (imageUrl.isNullOrEmpty()) {
                            for ((key, value) in allPrefs) {
                                if (key.contains("image", ignoreCase = true)) {
                                    val strValue = when (value) {
                                        is String -> value
                                        else -> value.toString()
                                    }
                                    if (strValue.isNotEmpty() && strValue.startsWith("http")) {
                                        imageUrl = strValue
                                        break
                                    }
                                }
                            }
                        }
                        
                        if (name != "Unknown" || !imageUrl.isNullOrEmpty()) {
                            break
                        }
                    }
                } catch (e: Exception) {
                    // Continue to next SharedPreferences name
                }
            }
            
            views.setTextViewText(R.id.tvName, name)
            
            if (!imageUrl.isNullOrEmpty()) {
                val cachedBitmap = loadImageFromCache(appContext, imageUrl!!)
                if (cachedBitmap != null) {
                    views.setImageViewBitmap(R.id.ivImage, cachedBitmap)
                } else {
                    views.setImageViewResource(R.id.ivImage, android.R.drawable.ic_menu_gallery)
                    
                    Thread {
                        try {
                            val bitmap = downloadAndCacheImage(appContext, imageUrl!!)
                            if (bitmap != null) {
                                Handler(Looper.getMainLooper()).post {
                                    val updatedViews = RemoteViews(context.packageName, R.layout.character_widget)
                                    updatedViews.setTextViewText(R.id.tvName, name)
                                    updatedViews.setImageViewBitmap(R.id.ivImage, bitmap)
                                    
                                    val intent = Intent(context, MainActivity::class.java)
                                    val pendingIntent = PendingIntent.getActivity(
                                        context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                                    )
                                    updatedViews.setOnClickPendingIntent(R.id.container, pendingIntent)
                                    
                                    appWidgetManager.updateAppWidget(widgetId, updatedViews)
                                }
                            }
                        } catch (e: Exception) {
                            // Handle error silently
                        }
                    }.start()
                }
            } else {
                views.setImageViewResource(R.id.ivImage, android.R.drawable.ic_menu_gallery)
            }

            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(R.id.container, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
    
    private fun loadImageFromCache(context: Context, urlString: String): Bitmap? {
        return try {
            val cacheDir = File(context.cacheDir, "widget_images")
            val cacheFileName = getCacheFileName(urlString)
            val cacheFile = File(cacheDir, cacheFileName)
            
            if (cacheFile.exists()) {
                BitmapFactory.decodeFile(cacheFile.absolutePath)
            } else {
                null
            }
        } catch (e: Exception) {
            null
        }
    }
    
    private fun downloadAndCacheImage(context: Context, urlString: String): Bitmap? {
        return try {
            val cacheDir = File(context.cacheDir, "widget_images")
            if (!cacheDir.exists()) {
                cacheDir.mkdirs()
            }
            
            val cacheFileName = getCacheFileName(urlString)
            val cacheFile = File(cacheDir, cacheFileName)
            
            val url = URL(urlString)
            val connection = url.openConnection()
            connection.connectTimeout = 15000
            connection.readTimeout = 15000
            connection.connect()
            
            val inputStream: InputStream = connection.getInputStream()
            
            val outputStream = FileOutputStream(cacheFile)
            val buffer = ByteArray(4096)
            var bytesRead: Int
            while (inputStream.read(buffer).also { bytesRead = it } != -1) {
                outputStream.write(buffer, 0, bytesRead)
            }
            outputStream.close()
            inputStream.close()
            
            BitmapFactory.decodeFile(cacheFile.absolutePath)
        } catch (e: Exception) {
            null
        }
    }
    
    /**
     * Generates a cache file name from URL using MD5 hash
     */
    private fun getCacheFileName(url: String): String {
        return try {
            val md = MessageDigest.getInstance("MD5")
            val hashBytes = md.digest(url.toByteArray())
            val hashString = hashBytes.joinToString("") { "%02x".format(it) }
            // Get file extension from URL if available
            val extension = url.substringAfterLast('.', "").takeIf { it.length <= 4 } ?: "jpg"
            "$hashString.$extension"
        } catch (e: Exception) {
            // Fallback to simple hash
            url.hashCode().toString() + ".jpg"
        }
    }
}

