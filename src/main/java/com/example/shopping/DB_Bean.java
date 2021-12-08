package com.example.shopping;

import java.sql.*;
import java.util.List;

//数据库javaBean
public class DB_Bean {
    private Connection con = null;//数据库连接
    private String dbStr;//连接地址字符串
    private String userName;//用户名
    private String password;//密码


    //数据库连接构造函数
    public DB_Bean() {
        dbStr = "连接地址字符串";
        userName = "用户名";
        password = "密码";
    }

    public DB_Bean(String dbStr, String userName, String password) {
        try {
            this.dbStr = dbStr;
            this.userName = userName;
            this.password = password;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //数据库连接
    public void connectDB(String dbStr, String userName, String password) {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(dbStr, userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //数据库连接
    public void connectDB() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(dbStr, userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //数据库搜索
    public boolean searchDB(String searchStr) {
        ResultSet rs = null;
        Statement stmt = null;
        String sqlSearch = searchStr;
        boolean searchRight = false;
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sqlSearch);
            searchRight = rs.next();
            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return searchRight;
    }

    //获取物品数据集
    public boolean getDataDB(String sql, List<Item_Bean> itemList) {
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;
        try {
            prepareStatement = con.prepareStatement(sql);
            rs = prepareStatement.executeQuery();
            while (rs.next()) {
                Item_Bean item = new Item_Bean();
                item.setItemId(Long.parseLong(rs.getString("itemId")));
                item.setItemName(rs.getString("itemName"));
                item.setItemPrice(Integer.parseInt(rs.getString("itemPrice")));
                itemList.add(item);
            }
            rs.close();
            prepareStatement.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //获取购物车物品数据集
    public boolean getShopCarDataDB(String sql, List<ShoppingCar_Bean> itemList) {
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;
        try {
            prepareStatement = con.prepareStatement(sql);
            rs = prepareStatement.executeQuery();
            while (rs.next()) {
                Item_Bean item = new Item_Bean();
                ShoppingCar_Bean shoppingCar_bean = new ShoppingCar_Bean();
                item.setItemId(Long.parseLong(rs.getString("itemId")));
                item.setItemName(rs.getString("itemName"));
                item.setItemPrice(Integer.parseInt(rs.getString("itemPrice")));
                shoppingCar_bean.setItemNum(Integer.parseInt(rs.getString("itemNum")));
                shoppingCar_bean.setItem(item);
                itemList.add(shoppingCar_bean);
            }
            rs.close();
            prepareStatement.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //获取单个数值
    public int getItemNumDB(String sql,String name) {
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;
        try {
            prepareStatement = con.prepareStatement(sql);
            rs = prepareStatement.executeQuery();
            int num = 0;
            while (rs.next()) {
                num = Integer.parseInt(rs.getString(name));
            }
            rs.close();
            prepareStatement.close();
            return num;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }


    //数据库更新
    public boolean updateDB(String sql) {
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;
        try {
            //取消事务的自动提交
            con.setAutoCommit(false);
            PreparedStatement pst1 = con.prepareStatement(sql);
            //执行 sql 语句
            pst1.executeUpdate();
            //提交事务
            con.commit();
            pst1.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    //数据库插入
    public boolean insertDB(String insertSql) {
        String sql = insertSql;
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
            ps.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //关闭数据库连接
    public boolean closeConnect() {
        try {
            con.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void setDbStr(String dbStr) {
        this.dbStr = dbStr;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
