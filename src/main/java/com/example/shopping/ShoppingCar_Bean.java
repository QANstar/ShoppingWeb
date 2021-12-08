package com.example.shopping;

public class ShoppingCar_Bean {
    private Item_Bean item;
    private int itemNum;

    public ShoppingCar_Bean() {
        item = new Item_Bean();
        itemNum = 0;
    }

    public ShoppingCar_Bean(Item_Bean item, int itemNum) {
        this.item = item;
        this.itemNum = itemNum;
    }

    public Item_Bean getItem() {
        return item;
    }

    public int getItemNum() {
        return itemNum;
    }

    public void setItem(Item_Bean item) {
        this.item = item;
    }

    public void setItemNum(int itemNum) {
        this.itemNum = itemNum;
    }
}
