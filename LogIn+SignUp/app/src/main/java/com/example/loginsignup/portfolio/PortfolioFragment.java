package com.example.loginsignup.portfolio;

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


public class PortfolioFragment extends Fragment {

    RecyclerView RvPortfolio;
    PortfoliioAdapter adapter;
    List<PortfolioItem> mdata;


    public PortfolioFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_portfolio, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        RvPortfolio = view.findViewById(R.id.rv_portfolio);

        // create list of portfolio items

        PortfolioItem item = new PortfolioItem("E-commerce Website", getString(R.string.ecommerce), R.drawable.web);
        PortfolioItem item2 = new PortfolioItem("Mobile Task Manager App", getString(R.string.mobile), R.drawable.app);
        PortfolioItem item3 = new PortfolioItem("Real-Time Data Processing Pipeline", getString(R.string.data), R.drawable.data);

        mdata = new ArrayList<>();
        mdata.add(item);
        mdata.add(item2);
        mdata.add(item3);

        // setup adapter and recyclerview

        RvPortfolio.setLayoutManager(new LinearLayoutManager(getContext()));
        adapter = new PortfoliioAdapter(mdata);
        RvPortfolio.setAdapter(adapter);

    }
}