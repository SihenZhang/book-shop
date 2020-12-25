package com.sihenzhang.service.impl;

import cn.hutool.crypto.digest.BCrypt;
import com.sihenzhang.dao.UserDao;
import com.sihenzhang.dao.impl.UserDaoImpl;
import com.sihenzhang.pojo.User;
import com.sihenzhang.service.UserService;

public class UserServiceImpl implements UserService {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    public void registerUser(User user) {
        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        userDao.saveUser(user);
    }

    @Override
    public User login(User loginUser) {
        User user = userDao.queryUserByUsername(loginUser.getUsername());
        if (BCrypt.checkpw(loginUser.getPassword(), user.getPassword())) {
            return user;
        } else {
            return null;
        }
    }

    @Override
    public boolean existUsername(String username) {
        return userDao.queryUserByUsername(username) != null;
    }
}
