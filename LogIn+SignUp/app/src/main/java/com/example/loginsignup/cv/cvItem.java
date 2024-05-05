package com.example.loginsignup.cv;

public class cvItem {

    private String title;
    private String description;

    public cvItem(String title, String description) {
        this.title = title;
        this.description = description;
    }

    public cvItem() {

    }

    public String getTitle(){
        return title;
    }

    public void setTitle(String title){
        this.title=title;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description){
        this.description = description;
    }



}
