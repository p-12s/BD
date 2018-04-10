-- create database
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Education')
    CREATE DATABASE Education
