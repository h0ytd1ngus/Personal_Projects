package com.hoytdingus.vappe;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

/**
 * Created by Cyrus on 1/22/15.
 */
public class ShopFile {


    public static void SaveShop(String filename, ArrayList<Shops> shopArray, Context context) {

        File external = context.getExternalFilesDir(null);
        File savedFile = new File(external, filename);

        try {

            FileOutputStream fos = new FileOutputStream(savedFile);
            ObjectOutputStream oos = new ObjectOutputStream(fos);

            oos.writeObject(shopArray);

            try {

                fos.close();
                oos.close();

            } catch (IOException e) {

                e.printStackTrace();

            }
        } catch(Exception e) {

            e.printStackTrace();

        }
    }

    public static ArrayList<Shops> ReadSavedShop(String filename, Context context) {

        ArrayList<Shops> shops = null;
        File ext = context.getExternalFilesDir(null);
        File savedFile = new File(ext, filename);

        if(!savedFile.exists()) {

            return null;

        }

        try {

            FileInputStream fis = new FileInputStream(savedFile);
            ObjectInputStream ois = new ObjectInputStream(fis);
            shops = (ArrayList<Shops>) ois.readObject();

        } catch(Exception e) {

            e.printStackTrace();
        }

        return shops;
    }

}
