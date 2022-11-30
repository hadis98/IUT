
class Manager :  public Person
{
    private:
        string ManagerEmail;

    public:
        void ViewCustomer ();
        void ViewProducts ();
        void ReceiveOrder (int Order_id);
        void CheckStock (Stock S);

};
