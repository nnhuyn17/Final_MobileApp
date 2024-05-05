package com.example.loginsignup;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class SignUpActivity extends AppCompatActivity {

    EditText email, name, company, phone, password, repassword;
    TextView directLogIn;
    com.google.android.material.button.MaterialButton goSignup;
    DBHelper myDB;
    private EditText edtDate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);

        email = (EditText)findViewById(R.id.Signupemail);
        name = (EditText)findViewById(R.id.fullname);
        company = (EditText)findViewById(R.id.company);
        phone = (EditText)findViewById(R.id.phonenumber);
        password = (EditText)findViewById(R.id.Signuppassword);
        repassword = (EditText)findViewById(R.id.repassword);

        edtDate = findViewById(R.id.editTextDate);

        goSignup =(com.google.android.material.button.MaterialButton)findViewById(R.id.goSignUp);
        directLogIn = (TextView)findViewById(R.id.directLogIn);

        myDB = new DBHelper(this);

        phone = (EditText)findViewById(R.id.phonenumber);
        phone.setInputType(InputType.TYPE_CLASS_NUMBER);

        edtDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ChonNgay();
            }
        });

        goSignup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String emailTxT = email.getText().toString();
                String nameTxt = name.getText().toString();
                String companyTxt = company.getText().toString();
                String phoneTxt = phone.getText().toString();
                String passwordTxt = password.getText().toString();
                String repasswordTxt = repassword.getText().toString();

                if (emailTxT.equals("") || passwordTxt.equals("")|| repasswordTxt.equals(""))
                {
                    Toast.makeText(SignUpActivity.this, "Please fill all fields", Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if (passwordTxt.equals(repasswordTxt))
                    {
                        Boolean emailcheckResult = myDB.checkemail(emailTxT);
                        if (emailcheckResult == false) {
                            Boolean regResult = myDB.insertData(emailTxT, passwordTxt);
                            if (regResult == true) {
                                Toast.makeText(SignUpActivity.this, "Signup Successfully.", Toast.LENGTH_SHORT).show();
                                Intent intent = new Intent(getApplicationContext(), LogInActivity.class);
                                startActivity(intent);
                            } else {
                                Toast.makeText(SignUpActivity.this, "Signup Failed", Toast.LENGTH_SHORT).show();
                            }
                        }
                        else
                        {
                            Toast.makeText(SignUpActivity.this, "Email already exists. Please Login", Toast.LENGTH_SHORT).show();
                        }
                    }
                    else
                    {
                            Toast.makeText(SignUpActivity.this, "Passwords do not match", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });

        directLogIn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), LogInActivity.class);
                startActivity(intent);
            }
        });
    }

    // Function to choose date
    private void ChonNgay() {
        Calendar calendar = Calendar.getInstance();
        int ngay = calendar.get(Calendar.DATE);
        int thang = calendar.get(Calendar.MONTH);
        int nam = calendar.get(Calendar.YEAR);
        DatePickerDialog datePickerDialog = new DatePickerDialog(SignUpActivity.this, new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int i, int i1, int i2) {
                // i: year - i1: month -- i2: day
                calendar.set(i, i1, i2);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                edtDate.setText(simpleDateFormat.format(calendar.getTime()));
            }
        }, nam, thang, ngay);
        // Set maximum date to today's date
        datePickerDialog.getDatePicker().setMaxDate(System.currentTimeMillis());
        datePickerDialog.show();
    }
}
