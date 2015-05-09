package com.hoytdingus.vappe;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

/**
 * Created by Cyrus on 1/13/15.
 */
public class ShopListFrag extends Fragment {

    public static ShopListFrag newInstance() {
        ShopListFrag fragment = new ShopListFrag();
        return fragment;
    }

    Shops    shops;
    ListView shopList;
    double lat;
    double lng;
    MapFrag shopsMap;

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);

        shopsMap = MapFrag.newInstance(getActivity());
        getFragmentManager().beginTransaction().replace(R.id.mapfrag, shopsMap, MapFrag.TAG).commit();


        return inflater.inflate(R.layout.shop_list_layout, container,false);
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        shopList = (ListView) getActivity().findViewById(R.id.listView);

        final LocationManager locationManager = (LocationManager) getActivity().getSystemService(Context.LOCATION_SERVICE);

        LocationListener locationListener = new LocationListener() {
            public void onLocationChanged(Location location) {

                lat = location.getLatitude();
                lng = location.getLongitude();

                // API CALL
                String API = "http://api.yelp.com/business_review_search?term=vape&amp;lat="+lat+"&amp;long="+lng+"&amp;radius=10&amp;limit=20&amp;ywsid=47Z4VIJZUvg42heLdcm-OA";
                ApiCall apiCall = new ApiCall();
                apiCall.execute(API);

                locationManager.removeUpdates(this);

                createList();

            }

            public void onStatusChanged(String provider, int status, Bundle extras) {}

            public void onProviderEnabled(String provider) {}

            public void onProviderDisabled(String provider) {}
        };

        if (MapFrag.latitude == 0 || MapFrag.longitude == 0){

            locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);

        } else {

            String API = "http://api.yelp.com/business_review_search?term=vape&amp;lat="+MapFrag.latitude+"&amp;long="+MapFrag.longitude+"&amp;radius=10&amp;limit=20&amp;ywsid=47Z4VIJZUvg42heLdcm-OA";
            ApiCall apiCall = new ApiCall();
            apiCall.execute(API);



        }



    }


    public void createList(){


        ShopListAdapt adapter = new ShopListAdapt(getActivity(), MainActivity.ShopList);
        shopList.setAdapter(adapter);

        shopList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                FragmentManager fragmentManager = getFragmentManager();
                fragmentManager.beginTransaction().replace(R.id.container, ShopDetailFrag.newInstance(i)).addToBackStack("").commit();
            }
        });

    }

protected class ApiCall extends AsyncTask<String, Void, String> {

    @Override
    protected String doInBackground(String... strings) {

        try {
            URL api = new URL (strings[0]);
            HttpURLConnection urlconnection = (HttpURLConnection) api.openConnection();
            urlconnection.connect();

            InputStream inputStream = urlconnection.getInputStream();
            String inputData = IOUtils.toString(inputStream);

            return inputData;

        } catch (MalformedURLException e){
            e.printStackTrace();
        } catch (IOException e){
            e.printStackTrace();
        }


        return null;
    }

    @Override
    protected void onPostExecute(String s) {
        super.onPostExecute(s);

        MainActivity.ShopList = new ArrayList<Shops>();
        String name;
        String shopImage;
        String reviewImage;
        String city;
        String zip;
        String state;
        String phone;
        String addy1;
        String addy2;
        String webAddy;
        int    dist;
        int    avgRate;

        try {

            JSONObject json = new JSONObject(s);
            JSONArray businesses = json.getJSONArray("businesses");
            JSONObject shop;

            for (int i = 0; i < businesses.length(); i ++) {
                shop        = businesses.getJSONObject(i);

                try {
                    name = shop.getString("name");
                } catch (Exception e){
                    name = "No Name Listed";
                }

                try {
                    shopImage = shop.getString("photo_url");
                } catch (Exception e){
                    shopImage = "";
                    e.printStackTrace();
                }

                try {
                    reviewImage = shop.getString("rating_img_url");
                } catch (Exception e){
                    reviewImage = "";
                    e.printStackTrace();
                }

                try {
                    city = shop.getString("city");

                } catch (Exception e){
                    city = "No City Listed";
                    e.printStackTrace();
                }

                try {
                    zip = shop.getString("zip");
                } catch (Exception e){
                    zip = "No Zipcode Listed";
                    e.printStackTrace();
                }

                try {
                    state = shop.getString("state");
                } catch (Exception e){
                    state = "No State Listed";
                    e.printStackTrace();
                }

                try {
                    phone = shop.getString("phone");
                } catch (Exception e){
                    phone = "No Phone Listed";
                    e.printStackTrace();
                }

                try {
                    addy1 = shop.getString("address1");
                } catch (Exception e){
                    addy1 = "No Address Listed";
                    e.printStackTrace();
                }

                try {
                    addy2 = shop.getString("address2");
                } catch (Exception e){
                    addy2 = "No Address Listed";
                    e.printStackTrace();
                }

                try {
                    webAddy = shop.getString("mobile_url");
                } catch (Exception e){
                    webAddy = "No Website Listed";
                    e.printStackTrace();
                }

                dist    = shop.getInt("distance");
                avgRate = shop.getInt("avg_rating");
                shops = new Shops();
                shops.buildShop(name, shopImage, reviewImage, city, zip, state, phone, addy1, addy2, webAddy, dist, avgRate);
                MainActivity.ShopList.add(shops);
            }

            createList();
            Log.i("","" +shopsMap);
            shopsMap.getShopMarkers();

        } catch (JSONException e) {
            e.printStackTrace();
        }



    }
}

}
