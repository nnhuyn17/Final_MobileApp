package com.example.loginsignup.contact;

import android.app.DatePickerDialog;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.loginsignup.R;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ContactFragment extends Fragment {

    private EditText editTextDateMeeting;
    private Spinner spinnerTime;
    private EditText editTextMessage;

    public ContactFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_contact, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        // Initialize views
        editTextDateMeeting = view.findViewById(R.id.editTextDateMeeting);
        spinnerTime = view.findViewById(R.id.spinnerTime);
        editTextMessage = view.findViewById(R.id.editTextMessage);

        // Set onClickListener for EditTextDateMeeting
        editTextDateMeeting.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ChonNgay();
            }
        });

        // Populate spinner with time periods
        List<String> timePeriods = new ArrayList<>();
        timePeriods.add("9am - 11am");
        timePeriods.add("1pm - 3pm");
        timePeriods.add("3pm - 5pm");
        timePeriods.add("5pm - 7pm");
        timePeriods.add("7pm - 9pm");

        ArrayAdapter<String> adapter = new ArrayAdapter<>(requireContext(), R.layout.spinner_item, timePeriods);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerTime.setAdapter(adapter);

        // Set onClickListener for Submit button
        view.findViewById(R.id.btnSubmit).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handleSubmit();
            }
        });
    }

    // Method to open DatePickerDialog
    private void ChonNgay() {
        Calendar calendar = Calendar.getInstance();
        int ngay = calendar.get(Calendar.DATE);
        int thang = calendar.get(Calendar.MONTH);
        int nam = calendar.get(Calendar.YEAR);
        DatePickerDialog datePickerDialog = new DatePickerDialog(requireContext(), new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                // Set chosen date in the EditText
                editTextDateMeeting.setText(dayOfMonth + "/" + (monthOfYear + 1) + "/" + year);
            }
        }, nam, thang, ngay);
        // Set minimum date to today's date
        datePickerDialog.getDatePicker().setMinDate(System.currentTimeMillis());
        datePickerDialog.show();
    }

    // Method to handle submit button click
    private void handleSubmit() {
        if (validateFields()) {
            // All fields are filled, show success message
            Toast.makeText(requireContext(), "Submit successfully", Toast.LENGTH_SHORT).show();
        } else {
            // Some fields are missing, show error message
            Toast.makeText(requireContext(), "Please fill all fields", Toast.LENGTH_SHORT).show();
        }
    }

    // Method to validate all fields
    private boolean validateFields() {
        String date = editTextDateMeeting.getText().toString().trim();
        String time = getSelectedTime();
        String message = getMessage();

        return !date.isEmpty() && !time.isEmpty() && !message.isEmpty();
    }

    // Method to retrieve the selected time from the spinner
    public String getSelectedTime() {
        return spinnerTime.getSelectedItem().toString();
    }

    // Method to retrieve the message entered in the EditText
    public String getMessage() {
        return editTextMessage.getText().toString().trim();
    }
}
