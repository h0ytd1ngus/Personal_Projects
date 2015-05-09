package com.hoytdingus.vappe;

import java.io.Serializable;

/**
 * Created by Cyrus on 1/13/15.
 */
public class Shops implements Serializable {

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

    protected void buildShop (String mName, String mShopImage, String mReviewImage, String mCity, String mZip, String mState, String mPhone, String mAddy1, String mAddy2, String mWebAddy, int mDist, int mAvgRate){

        name        = mName;
        shopImage   = mShopImage;
        reviewImage = mReviewImage;
        city        = mCity;
        zip         = mZip;
        state       = mState;
        phone       = mPhone;
        addy1       = mAddy1;
        addy2       = mAddy2;
        webAddy     = mWebAddy;
        dist        = mDist;
        avgRate     = mAvgRate;

    }

    public String getName() {
        return name;
    }

    public String getShopImage() {
        return shopImage;
    }

    public String getReviewImage() {
        return reviewImage;
    }

    public String getCity() {
        return city;
    }

    public String getZip() {
        return zip;
    }

    public String getState() {
        return state;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddy1() {
        return addy1;
    }

    public String getAddy2() {
        return addy2;
    }

    public String getWebAddy() {
        return webAddy;
    }

    public int getDist() {
        return dist;
    }

    public int getAvgRate() {
        return avgRate;
    }

    @Override
    public String toString() {
        return getName();
    }
}
