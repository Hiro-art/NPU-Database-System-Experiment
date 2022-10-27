# ER映射

~~~sql
--drop table book cascade
--drop table Author cascade
--drop table Publisher cascade
--drop table Customer cascade
--drop table Shipment cascade
--drop table order_ cascade
--drop table Promotion cascade
--drop table Category cascade
--drop table category_relate_book cascade
--drop table Book_relate_Author cascade
--drop table Total_Price_of_Order cascade
--drop table Duration_of_promotion cascade
--drop table LineItem cascade

create table Publisher
(
	PublisherID numeric(30) primary key,
	PublisherName char(10) NOT NULL,
	PublisherAddress char(30) NOT NULL,
	constraint publisher_alternateKey unique (PublisherName,PublisherAddress)
);

create table Book
(	
	PublisherID numeric(30) NOT NULL, 
	title char(30) NOT NULL,
 	ISBN char(9) NOT NULL,
	Edition char(10) NOT NULL,
	DateOfPublication char(30) NOT NULL,
	price float(10) NOT NULL,
	bookDescription char(30) NOT NULL,
	constraint PK_BOOK primary key (ISBN),--标识为主键
	constraint FK_BOOK_and_publisher foreign key (PublisherID) references Publisher(PublisherID) 
														--一本书对应一个出版商
);

create table Category
(	
	Category_ID numeric(30) primary key,
	Category_Name char(30) NOT NULL,
);
alter table Category add constraint column superid char(20);
alter table category add constraint fk_1 foreign key(superid) references category(Category_ID);


create table category_relate_book(
	Category_ID numeric(30) NOT NULL,
	ISBN char(9) NOT NULL,
	constraint PK_category_relate_book primary key(Category_ID,ISBN),
	constraint FK_Category_and_category2 foreign key (Category_ID) references Category(Category_ID),
	constraint FK_Book_and_category foreign key (ISBN) references Book (ISBN)
);

create table Author  --本质上是BOOK的一个多值属性
(	
	AuthorName char(30) NOT NULL,
	AuthorID char(30) NOT NULL,
	constraint PK_Author primary key (AuthorID)

);

create table Book_relate_Author --book和Author的中间表
(
	ISBN char(9) NOT NULL,
	AuthorID char(30) NOT NULL,
	constraint PK_Book_RELATE_Author primary key (ISBN, AuthorID),
	constraint FK_book_and_author foreign key (ISBN) REFERENCES Book(ISBN),
	constraint FK_Author foreign key (AuthorID) references Author(AuthorID)
);

create table Customer
(
	CustomerID char(30) primary key,
	--CustomerName char(30) NOT NULL, --复合属性
	Customer_FirstName char(10) NOT NULL,
	Customer_MiddleName char(10),
	Customer_LastName char(10) NOT NULL,
	MailingAddress char(30) NOT NULL,
	CreditCardNumber numeric(30) NOT NULL,
	ExpirationDate numeric(30) NOT NULL,
	PhoneNumber char(30) NOT NULL,
	EmailAddress char(30) NOT NULL,
	constraint Customer_alternateKey unique (CreditCardNumber,ExpirationDate)
);

create table Shipment
(
	DateOfShip char(30) NOT NULL,
	TrackingNumber char(30) primary key,
	DateOfExpectedDelivery char(30) NOT NULL
);

create table order_
(
	CustomerID char(30) NOT NULL,
	OrderNumber numeric(50) primary key,
	MailingAddress char(30) NOT NULL,
	MethodOfShipment char(30) NOT NULL,
	DateAndTimeOfOrder char(100) NOT NULL,
	--TotalPriceOfTheOrder  --这是一个多值、复合属性
	constraint FK_order_and_customer foreign key(CustomerID) references Customer(CustomerID)
);

create table Total_Price_of_Order(
	OrderNumber numeric(50) NOT NULL,
	TotalPrice numeric(50) NOT NULL,
	constraint PK_Total_Price_of_Order primary key (OrderNumber,TotalPrice),
	constraint FK_Total_Price_of_Order_and_Order foreign key (OrderNumber) references Order_(OrderNumber)
);


create table Promotion
(
	PromotionIDNumber char(30) primary key,
	Percentage_Discount_Points float(30) NOT NULL
	--Duration_of_Promotion --这是一个多值属性，创建一个新表
);

create table book_relate_promotion(
	PromotionIDNumber char(30) NOT NULL,
	ISBN char(9) NOT NULL,
	constraint PK_book_relate_promotion primary key (PromotionIDNumber,ISBN),
	constraint FK_promotion_and_promotion foreign key (PromotionIDNumber) references Promotion(PromotionIDNumber),
	constraint FK_Book_and_promotion foreign key (ISBN) references Book(ISBN)
);


create table Duration_of_promotion(
	PromotionIDNumber char(30) NOT NULL,
	startDate char(30) NOT NULL,
    endDate char(30) NOT NULL,
	constraint PK_Duration_of_promotion primary key (PromotionIDNumber,startDate,endDate),
	constraint FK_Duration_of_promotion_and_PromotionIDNumber foreign key (PromotionIDNumber) references Promotion(PromotionIDNumber)
);

create table LineItem(
	OrderNumber numeric(50) NOT NULL,
	TrackingNumber char(30) NOT NULL,
	ISBN char(9) NOT NULL,
	Total_price_for_each_book_that_is_ordered float(20) NOT NULL,
	Quantity_of_each_item_ordered numeric(100) NOT NULL,
	constraint PK_LineItem primary key(OrderNumber,ISBN),
	constraint FK_linitem_and_order foreign key (OrderNumber) references Order_(OrderNumber),
	constraint FK_linitem_and_shipment foreign key (TrackingNumber) references shipment(TrackingNumber),
	constraint FK_linitem_and_book foreign key (ISBN) references Book(ISBN)
);



~~~

