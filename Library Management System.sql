Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.44 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database library;
Query OK, 1 row affected (0.09 sec)

mysql> use library;
Database changed
mysql> create table author(
    -> author_id int primary key,
    -> author_name varchar(100) not null
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> create table book(
    -> book_id int primary key,
    -> title varchar(150) not null,
    -> author_id int,
    -> publisher varchar(100),
    -> year int,
    -> foreign key (author_id) references author(author_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> create table member(
    -> member_id int primary key,
    -> name varchar(100) not null,
    -> phone varchar(15),
    -> address varchar(200)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> create table librarian(
    -> librarian_id int primary key,
    -> name varchar(100) not null
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> create table issue(
    -> issue_id int primary key,
    -> book_id int,
    -> member_id int,
    -> librarian_id int,
    -> issue_date date,
    -> return_date date,
    -> foreign key (book_id) references book(book_id),
    -> foreign key (member_id) references member(member_id),
    -> foreign key (librarian_id) references librarian(librarian_id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> insert into author values(1,'APJ Abdul Kalam'),(2,'R.K Narayan'),(3,'Rabindranath Tagore');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> insert into book values(101,'Wings Of Fire',1,'Penguin Random House',2004),(102,'Malgudi Days',2,'Rupa Publications',2000),(103,'Gitanjali',3,'Harpercollins',2005);
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> insert into member values(1,'Pranay','9014738615','Vijayawada'),(2,'Chaitanya','8979695949','Mangalagiri'),(3,'Harsha','7868384858','Bhimavaram');
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> insert into librarian values(1,'Mr.Karthik'),(2,'Ms.Amrutha');
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into issue values(1,101,1,1,'2026-01-18','2026-02-28'),(1,102,2,2,'2026-02-17','2026-02-27');
ERROR 1062 (23000): Duplicate entry '1' for key 'issue.PRIMARY'
mysql> insert into issue values(1,101,1,1,'2026-01-18','2026-02-28'),(2,102,2,2,'2026-02-17','2026-02-27');
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select count(*) as total_books from book;
+-------------+
| total_books |
+-------------+
|           3 |
+-------------+
1 row in set (0.04 sec)

mysql> select member.name,book.title from issue join member on issue.member_id=member.member_id join book on issue.book_id=book.book_id;
+-----------+---------------+
| name      | title         |
+-----------+---------------+
| Pranay    | Wings Of Fire |
| Chaitanya | Malgudi Days  |
+-----------+---------------+
2 rows in set (0.03 sec)

mysql> select title from book where book_id in (select book_id from issue where member_id=1);
+---------------+
| title         |
+---------------+
| Wings Of Fire |
+---------------+
1 row in set (0.03 sec)

mysql> select member_id, count(*) as books_borrowed from issue group by member_id;
+-----------+----------------+
| member_id | books_borrowed |
+-----------+----------------+
|         1 |              1 |
|         2 |              1 |
+-----------+----------------+
2 rows in set (0.00 sec)


mysql> create view issued_books as select member.name,book.title,issue.issue_date from issue join member on issue.member_id=member.member_id join book on issue.book_id=book.book_id;
Query OK, 0 rows affected (0.04 sec)

mysql> desc author;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| author_id   | int          | NO   | PRI | NULL    |       |
| author_name | varchar(100) | NO   |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
2 rows in set (0.05 sec)

mysql> desc book;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| book_id   | int          | NO   | PRI | NULL    |       |
| title     | varchar(150) | NO   |     | NULL    |       |
| author_id | int          | YES  | MUL | NULL    |       |
| publisher | varchar(100) | YES  |     | NULL    |       |
| year      | int          | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
5 rows in set (0.00 sec)

mysql> desc member;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| member_id | int          | NO   | PRI | NULL    |       |
| name      | varchar(100) | NO   |     | NULL    |       |
| phone     | varchar(15)  | YES  |     | NULL    |       |
| address   | varchar(200) | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> desc librarian;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| librarian_id | int          | NO   | PRI | NULL    |       |
| name         | varchar(100) | NO   |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> desc issue;
+--------------+------+------+-----+---------+-------+
| Field        | Type | Null | Key | Default | Extra |
+--------------+------+------+-----+---------+-------+
| issue_id     | int  | NO   | PRI | NULL    |       |
| book_id      | int  | YES  | MUL | NULL    |       |
| member_id    | int  | YES  | MUL | NULL    |       |
| librarian_id | int  | YES  | MUL | NULL    |       |
| issue_date   | date | YES  |     | NULL    |       |
| return_date  | date | YES  |     | NULL    |       |
+--------------+------+------+-----+---------+-------+
6 rows in set (0.03 sec)

mysql>
