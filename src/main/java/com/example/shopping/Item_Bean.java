package com.example.shopping;

public class Item_Bean {
    private long itemId;
    private String itemName;
    private int itemPrice;

    public Item_Bean() {
    }

    public Item_Bean(long itemId, String itemName, int itemPrice) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
    }


    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }
}
