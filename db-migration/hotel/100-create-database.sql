-- create database
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Booking')
    CREATE DATABASE Booking
