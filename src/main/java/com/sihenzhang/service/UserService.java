package com.sihenzhang.service;

import com.sihenzhang.pojo.User;

public interface UserService {
    void registerUser(User user);

    User login(User loginUser);

    boolean existUsername(String username);
}
