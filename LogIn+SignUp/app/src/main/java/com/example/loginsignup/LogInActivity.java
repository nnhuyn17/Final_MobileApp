package com.example.loginsignup;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class LogInActivity extends AppCompatActivity {

    EditText email, password;
    TextView directSignUp;
    com.google.android.material.button.MaterialButton goLogIn;
    DBHelper myDB;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_log_in);

        email = (EditText)findViewById(R.id.Loginemail);
        password = (EditText)findViewById(R.id.Loginpassword);
        directSignUp =(TextView)findViewById(R.id.directSignUp);
        goLogIn =(com.google.android.material.button.MaterialButton)findViewById(R.id.goLogIn);

        myDB = new DBHelper(this);

        goLogIn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String emailTxt = email.getText().toString();
                String passwordTxt = password.getText().toString();

                // Check if email and password are empty
                if (emailTxt.equals("") || passwordTxt.equals("")) {
                    Toast.makeText(LogInActivity.this, "Please enter your email and password", Toast.LENGTH_SHORT).show();
                } else {
                    Boolean result = myDB.checkemailpassword(emailTxt,passwordTxt);
                    if (result == true) {
                        // If login is successful, start MainActivity
                        Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                        startActivity(intent);
                    } else {
                        Toast.makeText(LogInActivity.this, "Login failed. Please check your credentials.", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });

        directSignUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), SignUpActivity.class);
                startActivity(intent);
            }
        });
    }
}
