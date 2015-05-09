package com.hoytdingus.vappe;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.loopj.android.image.SmartImageView;

import java.util.ArrayList;

/**
 * Created by Cyrus on 1/13/15.
 */
public class ShopListAdapt extends BaseAdapter {

    private static final int ID_CONSTANT = 0x01000000;

    Context mContext;
    ArrayList<Shops> shops;


    public ShopListAdapt(Context context, ArrayList<Shops>adaptShops){

        mContext = context;
        shops = adaptShops;

    }


    @Override
    public int getCount() {
        if (shops != null){
            return shops.size();
        } else {
            return 0;
        }
    }

    @Override
    public Object getItem(int i) {
        if (shops != null && i < shops.size() && i >= 0) {
            return shops.get(i);
        } else {
            return null;
        }
    }

    @Override
    public long getItemId(int i) {
        return ID_CONSTANT + i;
    }


    static class ViewHolder{

        SmartImageView image;
        SmartImageView reviewImage;
        TextView title;
        TextView mileage;

        public ViewHolder(View view){
            title = (TextView) view.findViewById(R.id.title);
            image = (SmartImageView) view.findViewById(R.id.image);
            reviewImage = (SmartImageView) view.findViewById(R.id.reviewImage);
            mileage = (TextView) view.findViewById(R.id.mileage);

        }
    }


    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder cell;
        if (view == null) {

            view = LayoutInflater.from(mContext).inflate(R.layout.customcell, viewGroup, false);
            cell = new ViewHolder(view);
            view.setTag(cell);

        } else {

            cell = (ViewHolder)view.getTag();

        }

        Shops shop = (Shops)getItem(i);
        cell.title.setText(shop.getName());
        cell.image.setImageUrl(shop.getShopImage());
        cell.reviewImage.setImageUrl(shop.getReviewImage());
        cell.mileage.setText(shop.dist + " mi." );


        return view;
    }
}
