package com.sihenzhang.utils;

import cn.hutool.db.DbUtil;
import cn.hutool.db.ds.DSFactory;
import lombok.extern.slf4j.Slf4j;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Slf4j
public final class DbUtils {
    private static final DataSource DATA_SOURCE = DSFactory.get();
    private static final ThreadLocal<Connection> CONNECTION_THREAD_LOCAL = new ThreadLocal<>();

    public static Connection getConnection() {
        Connection connection = CONNECTION_THREAD_LOCAL.get();
        if (connection == null) {
            try {
                connection = DATA_SOURCE.getConnection();
                CONNECTION_THREAD_LOCAL.set(connection);
                connection.setAutoCommit(false);
            } catch (SQLException e) {
                log.error("Failed to get database connection from datasource; nested exception is " + e, e);
            }
        }
        return connection;
    }

    public static void commitAndClose() {
        Connection connection = CONNECTION_THREAD_LOCAL.get();
        if (connection != null) {
            try {
                connection.commit();
            } catch (SQLException e) {
                log.error("Failed to commit transaction; nested exception is " + e, e);
            } finally {
                DbUtil.close(connection);
            }
        }
        // 一定要执行remove操作，否则就会出错（因为Tomcat服务器底层使用了线程池）
        CONNECTION_THREAD_LOCAL.remove();
    }

    public static void rollbackAndClose() {
        Connection connection = CONNECTION_THREAD_LOCAL.get();
        if (connection != null) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                log.error("Failed to rollback transaction; nested exception is " + e, e);
            } finally {
                DbUtil.close(connection);
            }
        }
        // 一定要执行remove操作，否则就会出错（因为Tomcat服务器底层使用了线程池）
        CONNECTION_THREAD_LOCAL.remove();
    }
}
