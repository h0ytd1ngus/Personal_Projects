package com.hoytdingus.vappe;

import android.app.Activity;
import android.app.Fragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

/**
 * Created by Cyrus on 1/15/15.
 */
public class OhmCalcFrag extends Fragment implements View.OnClickListener {

    EditText inputRes;
    EditText inputVolts;
    TextView resultsAmps;
    TextView resultsWatts;
    Button submit;


    public static OhmCalcFrag newInstance() {
        OhmCalcFrag fragment = new OhmCalcFrag();
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

        View v = inflater.inflate(R.layout.ohm_calc_frag_layout, container,false);
        inputRes = (EditText) v.findViewById(R.id.input_ohms);
        inputVolts = (EditText) v.findViewById(R.id.input_volts);
        resultsAmps = (TextView) v.findViewById(R.id.amp_results);
        resultsWatts = (TextView) v.findViewById(R.id.watt_results);
        submit = (Button) v.findViewById(R.id.submit);


        return v;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        submit.setOnClickListener(this);
    }

    public void doMath(){

        double amperage = 0.0;
        double resistance = 0.0;
        double wattage = 0.0;
        double voltage = 0.0;

        if (inputVolts.length() > 0 && inputRes.length() > 0){

            voltage = Double.parseDouble(inputVolts.getText().toString());
            resistance = Double.parseDouble(inputRes.getText().toString());
            amperage = voltage / resistance;
            amperage = (double) (Math.round(amperage * 100)) / 100;

            wattage = voltage * amperage;
            wattage = (double) (Math.round(wattage * 100)) / 100;

            if (wattage == 0.0 || voltage == 0.0){

                resultsWatts.setText("0.0");
                resultsAmps.setText("0.0");

            } else {

                resultsWatts.setText(""+wattage+" Watts");
                resultsAmps.setText(""+amperage+" Amps");

            }
        }
    }

    @Override
    public void onClick(View view) {
       doMath();
    }
}
