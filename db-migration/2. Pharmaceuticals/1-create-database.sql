-- create database
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Pharmaceuticals')
    CREATE DATABASE Pharmaceuticals
