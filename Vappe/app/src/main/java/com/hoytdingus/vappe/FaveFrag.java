package com.hoytdingus.vappe;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.ListFragment;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * Created by Cyrus on 1/15/15.
 */
public class FaveFrag extends ListFragment implements AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener{

    public static FaveFrag newInstance() {
        FaveFrag fragment = new FaveFrag();
        return fragment;
    }

    ArrayList<Shops> savedShops;
    ArrayAdapter<Shops> savedAdapt;
    ListView faveList;


    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);

        View v = inflater.inflate(R.layout.fave_frag_layout, container,false);

        return v;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //faveList.setOnItemClickListener(this);
        savedShops = ShopFile.ReadSavedShop("Favorites", getActivity());

        faveList = getListView();
        faveList.setOnItemClickListener(this);
        faveList.setOnItemLongClickListener(this);

        Log.i("saved"," shops: " + savedShops);
        if (savedShops != null) {
            savedAdapt = new ArrayAdapter<Shops>(getActivity(), android.R.layout.simple_list_item_1, savedShops);
            faveList.setAdapter(savedAdapt);
        }

    }


    @Override
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {

        FragmentManager fragmentManager = getFragmentManager();
        fragmentManager.beginTransaction().replace(R.id.container, ShopDetailFrag.newInstance(i)).addToBackStack("").commit();

    }

    @Override
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {

        Toast.makeText(getActivity(), savedShops.get(i) + ", has been removed from Favorites", Toast.LENGTH_SHORT).show();
        savedShops.remove(i);
        ShopFile.SaveShop("Favorites", savedShops, getActivity());
        ArrayAdapter<Shops> newAdapt = new ArrayAdapter<Shops>(getActivity(), android.R.layout.simple_list_item_1, savedShops);
        faveList.setAdapter(newAdapt);
        return true;
    }
}
