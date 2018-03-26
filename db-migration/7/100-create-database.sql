-- create database
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'BookingRooms')
    CREATE DATABASE Pharmaceuticals
