package com.sihenzhang.dao;

import com.sihenzhang.pojo.User;

public interface UserDao {
    User queryUserByUsername(String username);

    int saveUser(User user);
}
