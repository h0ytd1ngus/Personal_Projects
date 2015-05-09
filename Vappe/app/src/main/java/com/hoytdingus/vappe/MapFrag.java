package com.hoytdingus.vappe;

import android.content.Context;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;


import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

/**
 * Created by Cyrus on 1/24/15.
 */
public class MapFrag extends MapFragment {

    GoogleMap gooMap;
    Context context;
    int position;
    boolean isDetail;

    public static double latitude;
    public static double longitude;

    public static final String TAG = "MAPFRAG";


    public static MapFrag newInstance(Context _context) {
        MapFrag mapfrag = new MapFrag();
        mapfrag.context = _context;
        return mapfrag;

    }

    public static MapFrag newDetailInstance(Context _context, int _position) {
        MapFrag mapfrag = new MapFrag();
        mapfrag.isDetail = true;
        mapfrag.context = _context;
        mapfrag.position = _position;
        return mapfrag;

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {


        return super.onCreateView(inflater, container, savedInstanceState);
    }


    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        gooMap = getMap();

        LocationManager locationManager = (LocationManager) getActivity().getSystemService(Context.LOCATION_SERVICE);

        LocationListener locationListener = new LocationListener() {
            public void onLocationChanged(Location location) {
                latitude = location.getLatitude();
                longitude = location.getLongitude();

                goToLocation(latitude, longitude, 10);
                LatLng myLL = new LatLng(latitude, longitude);
                gooMap.addMarker(new MarkerOptions()
                        .position(myLL)
                        .title("you are here")
                        .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE)));

            }

            public void onStatusChanged(String provider, int status, Bundle extras) {
            }

            public void onProviderEnabled(String provider) {
            }

            public void onProviderDisabled(String provider) {
            }
        };

        locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);


        if (isDetail) {
            loadMap(this.position);
        }
    }

    public void getShopMarkers () {

        for (int i = 0; i < MainActivity.ShopList.size(); i++) {
            /// shop list is null here got to figure out how to get the shop correctly  it is a timing issue.
            LatLng coords = getShopCoordinates(i);

            if (coords == null){

                Toast.makeText(context, "No Coordinates Found for " +MainActivity.ShopList.get(i).getName()+"", Toast.LENGTH_SHORT);

            } else {
                oneShop(i, coords);
            }
        }
    }


    public void oneShop (int num , LatLng pos){

        gooMap.addMarker(new MarkerOptions()
                .title(MainActivity.ShopList.get(num).getName())
                .position(pos));

    }


    private void goToLocation(double lat, double lng, float zoom) {

        LatLng ll = new LatLng(lat, lng);
        CameraUpdate update = CameraUpdateFactory.newLatLngZoom(ll, zoom);
        gooMap.moveCamera(update);

    }

    public LatLng getShopCoordinates(int i) {


        Geocoder geocoder = new Geocoder(context);


        LatLng shopLL;
        try {

                List<Address> list = geocoder.getFromLocationName(MainActivity.ShopList.get(i).getAddy1(), 20);
                if (list != null && list.size() > 0){

                    Address add = list.get(0);
                    //String locality = add.getLocality();
                    //Toast.makeText(context, locality, Toast.LENGTH_LONG).show();

                    double shopLatitude = add.getLatitude();
                    double shopLongitude = add.getLongitude();
                    shopLL = new LatLng(shopLatitude,shopLongitude);

                    goToLocation(shopLatitude, shopLongitude, 10);

                    return shopLL;
                } else {

                    Toast.makeText(context, "No Address available for "+MainActivity.ShopList.get(i).getName()+"", Toast.LENGTH_LONG).show();
                }

        } catch (IOException e) {

        }
                return null;
    }

    public void loadMap(int i) {
        LatLng coords = getShopCoordinates(i);
        oneShop(i, coords);
    }
}