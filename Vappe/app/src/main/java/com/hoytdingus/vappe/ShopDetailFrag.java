package com.hoytdingus.vappe;

import android.app.Activity;
import android.app.Fragment;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.model.LatLng;
import com.loopj.android.image.SmartImageView;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by Cyrus on 1/15/15.
 */
public class ShopDetailFrag extends Fragment implements Serializable {

    int position;
    Shops selectedShop;

    MapFrag mapFrag;

    public static ShopDetailFrag newInstance(int i) {
        ShopDetailFrag fragment = new ShopDetailFrag();
        fragment.position = i;
        fragment.selectedShop = MainActivity.ShopList.get(fragment.position);
        return fragment;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);



        return inflater.inflate(R.layout.shop_detail_frag_layout, container,false);
    }

    @Override
    public void onActivityCreated(final Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        mapFrag = MapFrag.newDetailInstance(getActivity(), position);

        getFragmentManager().beginTransaction().replace(R.id.detailMapFrag, mapFrag, MapFrag.TAG).commit();

        ImageButton addButton = (ImageButton) getActivity().findViewById(R.id.addButton);
               addButton.setOnClickListener(new View.OnClickListener() {
                   @Override
                   public void onClick(View view) {

                       ArrayList<Shops> savedShops = ShopFile.ReadSavedShop("Favorites", getActivity());

                       if(savedShops == null) {
                           savedShops = new ArrayList<Shops>();
                       }

                       savedShops.add(selectedShop);
                       ShopFile.SaveShop("Favorites", savedShops, getActivity());
                       Toast.makeText(getActivity(), selectedShop.getName() + ", has been added to Favorites", Toast.LENGTH_SHORT).show();

                   }
               });

        TextView title = (TextView) getActivity().findViewById(R.id.detailShopName);
        title.setText(selectedShop.getName());

        TextView addy = (TextView) getActivity().findViewById(R.id.detailAddy);
        addy.setText(selectedShop.getAddy1() + ", "+ selectedShop.getCity()+ ", " + selectedShop.getState() + " " + selectedShop.getZip());

        TextView phone = (TextView) getActivity().findViewById(R.id.detailPhone);
        phone.setText(selectedShop.getPhone());

        TextView shopWeb = (TextView) getActivity().findViewById(R.id.detailWeb);
        shopWeb.setText(selectedShop.getWebAddy());

        TextView rating = (TextView) getActivity().findViewById(R.id.detailRating);
        rating.setText(""+ selectedShop.getAvgRate() +"");

        SmartImageView shopRateImg = (SmartImageView) getActivity().findViewById(R.id.detailReviewImage);
        shopRateImg.setImageUrl(selectedShop.getReviewImage());



    }


}
