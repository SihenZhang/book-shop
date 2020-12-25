package com.sihenzhang.dao.impl;

import cn.hutool.db.handler.BeanHandler;
import cn.hutool.db.handler.BeanListHandler;
import cn.hutool.db.handler.NumberHandler;
import cn.hutool.db.sql.SqlExecutor;
import com.sihenzhang.utils.DbUtils;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@Slf4j
public abstract class BaseDao {
    public int update(String sql, Object... args) {
        Connection connection = DbUtils.getConnection();
        try {
            return SqlExecutor.execute(connection, sql, args);
        } catch (SQLException e) {
            log.error("Failed to execute SQL statement: \"" + sql + "\"; nested exception is " + e, e);
            throw new RuntimeException(e);
        }
    }

    public <T> T queryForOne(Class<T> type, String sql, Object... args) {
        Connection connection = DbUtils.getConnection();
        try {
            return SqlExecutor.query(connection, sql, BeanHandler.create(type), args);
        } catch (SQLException e) {
            log.error("Failed to execute SQL statement: \"" + sql + "\"; nested exception is " + e, e);
            throw new RuntimeException(e);
        }
    }

    public <T> List<T> queryForList(Class<T> type, String sql, Object... args) {
        Connection connection = DbUtils.getConnection();
        try {
            return SqlExecutor.query(connection, sql, BeanListHandler.create(type), args);
        } catch (SQLException e) {
            log.error("Failed to execute SQL statement: \"" + sql + "\"; nested exception is " + e, e);
            throw new RuntimeException(e);
        }
    }

    public Number queryForSingleNumber(String sql, Object... args) {
        Connection connection = DbUtils.getConnection();
        try {
            return SqlExecutor.query(connection, sql, NumberHandler.create(), args);
        } catch (SQLException e) {
            log.error("Failed to execute SQL statement: \"" + sql + "\"; nested exception is " + e, e);
            throw new RuntimeException(e);
        }
    }
}
