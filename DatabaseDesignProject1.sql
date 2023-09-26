
-- Following on from designing the Schema, I write the following queries to create all the required tables in my schema. 

 CREATE TABLE Hotel (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100),
    HotelType VARCHAR(50),
    HotelLocation VARCHAR(100),
    CheckInDate DATE,
    CheckOutDate DATE,
    PricePerNight DECIMAL(10, 2),
    StarRating INT);


 CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PaymentDetails VARCHAR(255) NOT NULL,
    PasswordHash VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    TravelPreferences TEXT,
    LoyaltyRewards INT,
    
    CONSTRAINT CHK_PhoneOrEmailNotNull
        CHECK ((Phone IS NOT NULL) OR (Email IS NOT NULL))
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    HotelID INT NOT NULL,
    BookingDate DATETIME NOT NULL,
    BookingStatus VARCHAR(50) NOT NULL,
    PaymentInformation VARCHAR(255) NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT FK_CustomerBooking FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID),
    
    CONSTRAINT FK_HotelBooking FOREIGN KEY (HotelID)
    REFERENCES Hotel (HotelID)
);


	CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    CustomerID INT not null,
    HotelID INT not null,
    BookingID INT not null,
    Rating INT,
    Comments TEXT,
    ReviewDate Timestamp not null,
    
    CONSTRAINT FK_CustomerReview FOREIGN KEY (CustomerID)
    REFERENCES dbo.Customers (CustomerID),
    
    CONSTRAINT FK_HotelReview FOREIGN KEY (HotelID)
    REFERENCES dbo.Hotel (HotelID),
    
    CONSTRAINT FK_BookingReview FOREIGN KEY (BookingID)
    REFERENCES Bookings (BookingID)
	);

	CREATE TABLE Hotel (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100),
    HotelType VARCHAR(50),
    HotelLocation VARCHAR(100),
    CheckInDate DATE,
    CheckOutDate DATE,
    PricePerNight DECIMAL(10, 2),
    StarRating INT
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus VARCHAR(50),
    PaymentMethod VARCHAR(50) NOT NULL,
    ConfirmationNumber VARCHAR(100) NOT NULL,
    
    CONSTRAINT FK_BookingPayment FOREIGN KEY (BookingID)
    REFERENCES Bookings (BookingID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentID INT NOT NULL,
    CustomerID INT NOT NULL,
    TransactionDate DATE NOT NULL,
    TransactionType VARCHAR(50),
    TransactionStatus VARCHAR(50) NOT NULL,
    
    CONSTRAINT FK_BookingTransaction FOREIGN KEY (BookingID)
    REFERENCES Bookings (BookingID),
    
    CONSTRAINT FK_PaymentTransaction FOREIGN KEY (PaymentID)
    REFERENCES Payments (PaymentID),
    
    CONSTRAINT FK_CustomerTransaction FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE Segmentation (
    SegmentID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SegmentName VARCHAR(50),
    Description TEXT,
    Criteria VARCHAR(255),
    
    CONSTRAINT FK_CustomerSegment FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY,
    CustomerID INT,
    NotificationType VARCHAR(50),
    Message TEXT,
    NotificationDate DATETIME,
    
    CONSTRAINT FK_CustomerNotification FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE AnalyticsPerformance (
    AnalyticsID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AppUsageDuration INT,
    PageViews INT,
    Errors INT,
    PerformanceScore DECIMAL(5, 2),
    AnalyticsDate DATE,
    
    CONSTRAINT FK_CustomerAnalytics FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE CustomerSupport (
    SupportID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OpenDate DATETIME,
    ClosedDate DATETIME,
	Priority VARCHAR(50),
	SupportType VARCHAR(50),
	Description TEXT,  
	
    CONSTRAINT FK_CustomerSupport FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE UserBehavior (
    BehaviorID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PageVisited VARCHAR(100),
    ActionTaken VARCHAR(100),
    DeviceType VARCHAR(50),
	IPAddress VARCHAR(100),
	BehaviorDate DATETIME,
    
    CONSTRAINT FK_CustomerBehavior FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);

CREATE TABLE Time (
    TimeID INT PRIMARY KEY,
    BehaviorID INT NOT NULL,
    Date DATE NOT NULL,
    DayOfWeek INT NOT NULL,
    Month INT NOT NULL,
    Quarter INT NOT NULL,
    Year INT NOT NULL,
    
    CONSTRAINT FK_BehaviorTime FOREIGN KEY (BehaviorID)
    REFERENCES UserBehavior (BehaviorID)
);

CREATE TABLE GeographicalLocation (
    LocationID INT PRIMARY KEY,
    BehaviorID INT NOT NULL,
    City VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL,
	Country VARCHAR(100) NOT NULL,
    Timezone VARCHAR(50) NOT NULL,
    Latitude DECIMAL(9, 6) NOT NULL,
    Longitude DECIMAL(9, 6) NOT NULL,

    CONSTRAINT FK_BehaviorLocation FOREIGN KEY (BehaviorID)
    REFERENCES UserBehavior (BehaviorID)
);

CREATE TABLE Expenses (
    ExpenseID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
	Description VARCHAR(255) NOT NULL,
    Category VARCHAR(50),
    Amount DECIMAL(10, 2) NOT NULL,
    ExpenseDate DATE NOT NULL,
    ReceiptImage VARCHAR(255), -- Users can store a path or URL to the receipt image.
    Notes TEXT,
    CreatedBy INT, -- This will be a foreign key referencing the customer table for tracking who created the expense.
    CreatedOn DATETIME, -- Timestamp for when the expense was created.
    
	CONSTRAINT FK_CustomerExpense FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID),
    CONSTRAINT CHK_AmountPositive CHECK (Amount >= 0)
);











