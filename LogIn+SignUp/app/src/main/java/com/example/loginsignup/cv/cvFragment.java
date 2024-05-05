package com.example.loginsignup.cv;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.loginsignup.R;

import java.util.ArrayList;
import java.util.List;


public class cvFragment extends Fragment {

    RecyclerView RvCv;
    cvAdapter adapter;
    List<cvItem> items;
    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        RvCv = view.findViewById(R.id.recyclerview_cv);

        // create a list of items
        items = new ArrayList<>();
        items.add(new cvItem("UI/UX Designer", getString(R.string.text1)));
        items.add(new cvItem("Software Engineer", getString(R.string.text2)));
        items.add(new cvItem("Front-end Developer", getString(R.string.text3)));
        items.add(new cvItem("Mobile Developer", getString(R.string.text4)));

        adapter = new cvAdapter(items);

        RvCv.setLayoutManager(new LinearLayoutManager(getContext()));
        RvCv.setAdapter(adapter);

    }

    public cvFragment () {

    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_cv, container, false);
    }
}