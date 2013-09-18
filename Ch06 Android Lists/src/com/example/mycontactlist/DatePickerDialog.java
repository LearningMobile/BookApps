package com.example.mycontactlist;

import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.text.format.Time;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.DatePicker;

public class DatePickerDialog extends DialogFragment {

	public interface SaveDateListener {
		void didFinishDatePickerDialog(Time selectedTime);
	}

    public DatePickerDialog() {
        // Empty constructor required for DialogFragment
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.dateselect, container);

        getDialog().setTitle("Select Date");
        
    	final DatePicker dp = (DatePicker) view.findViewById(R.id.birthdayPicker);

		Button saveButton = (Button) view.findViewById(R.id.btnOk);
		saveButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
                Time selectedTime = new Time();
                selectedTime.set(dp.getDayOfMonth(), dp.getMonth(), dp.getYear());
                saveItem(selectedTime);					
			}
		});
		Button cancelButton = (Button) view.findViewById(R.id.btnCancel);
		cancelButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				getDialog().dismiss();
			}
		});

       return view;
    }
    
    private void saveItem(Time selectedTime) {
    	SaveDateListener activity = (SaveDateListener) getActivity();
    	activity.didFinishDatePickerDialog(selectedTime);
    	getDialog().dismiss();
    }

}