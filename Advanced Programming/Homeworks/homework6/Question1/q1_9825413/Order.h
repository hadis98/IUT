
class Order
{
    private:
        int OrderID;
        int CustomerId;
        string Customername;
        int Product_id;
        float Amount;
        DateTime OrderDate;

    public:
        void CreateOrder ();
        void EditOrder (int OrderID);

};
