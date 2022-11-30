#include <iostream>
using namespace std;
class human
{
protected:
    string fullName;
    long int NationalCode;
    string gender;
    long int income = 0;
public:
    human(string, long int, string);
    human();
    virtual long int calculate_income() { return income; };
    virtual double calculate_tax() { return 0; };
    virtual long int pay_salary() { return 0; };
    virtual long int cost(double Cost) { income -= Cost; return income; };
};

human::human(string _fullName, long int _NationalCode, string _gender)
{
    fullName = _fullName;
    NationalCode = _NationalCode;
    gender = _gender;
}
human::human() {}
class student :public human//****************** student
{
protected:
    int student_id;

public:
    student(string, long int, string, int);

};

student::student(string _fullName, long int _NationalCode, string _gender, int _studentId) :human(_fullName, _NationalCode, _gender)
{
    income = 500000;
    student_id = _studentId;
}
class employee :public human//************ employee
{
protected:
    int personnelCODE;
    long int baseOFsalary;
    double Tax;
public:
    employee(string, long int, string, long int, int);
    employee();
    double calculate_tax() { return Tax; }
    long int  calculate_income() { return baseOFsalary; }
    long int cost(double Cost) { income -= Cost; return income; };
    long int pay_salary() { income += baseOFsalary - Tax; return income; };
};

employee::employee(string _fullName, long int _NationalCode, string _gender, long int _baseOFsalary, int code) :human(_fullName, _NationalCode, _gender)
{
    baseOFsalary = _baseOFsalary;
    Tax = 0.15 * baseOFsalary;
    personnelCODE = code;
}
employee::employee() {}
class partTimeEmployee :public employee//*************** partTimeEmployee
{
protected:
    int hoursOFwork;
public:
    partTimeEmployee(string, long int, string, long int, int, int);
    partTimeEmployee();
    long int calculate_income() { return baseOFsalary; }

};

partTimeEmployee::partTimeEmployee(string _fullName, long int _NationalCode, string _gender, long int _baseOFsalary, int code, int _hoursOFwork) :employee(_fullName, _NationalCode, _gender, _baseOFsalary, code)
{
    hoursOFwork = _hoursOFwork;
    baseOFsalary = hoursOFwork * 100000;
    Tax = 0.15 * baseOFsalary;
}
partTimeEmployee::partTimeEmployee() {}
class student_with_job : public student, public partTimeEmployee //************* student with job
{
    long int salary = 0;
    long int income = 500000;
public:
    student_with_job(string _fullName, long int _NationalCode, string _gender, long int _baseOFsalary, int code, int hours) :student(_fullName, _NationalCode, _gender, code), partTimeEmployee(_fullName, _NationalCode, _gender, _baseOFsalary, code, hours)
    {
        personnelCODE = student_id;
        hoursOFwork = hours;
        salary = 30000 * hoursOFwork;
        Tax = 0;
    }    
    double calculate_tax() { return Tax; };
    long int pay_salary() {income += salary - Tax; return income; };
    long int calculate_income() { return salary; }
};


class professor :public human //***************** professor
{
    int professor_id;
    int hoursOFteach;
    string levelOFprofessor;
    double Tax;
    long int salary = 0;
public:
    professor(string, long int, string, string, int, int);
    long int calculate_income() { return salary; };
    double calculate_tax() { return Tax; };
    long int pay_salary() { income += salary - Tax; return income; };
};

professor::professor(string _fullName, long int _NationalCode, string _gender, string level, int id, int hours) :human(_fullName, _NationalCode, _gender)
{
    professor_id = id;
    hoursOFteach = hours;
    levelOFprofessor = level;
    if (levelOFprofessor == "morabi")
        salary = 3000000 + (150000 * hoursOFteach);
    else if (levelOFprofessor == "ostadyar")
        salary = 4000000 + (150000 * hoursOFteach);
    else if (levelOFprofessor == "daneshyar")
        salary = 5000000 + (150000 * hoursOFteach);
    else// ostad
        salary = 6000000 + (150000 * hoursOFteach);

    Tax = 0.1 * salary;
}
int main()
{
    human* h;
    student st1("hadis ghafouri", 123456, "girl", 13);
    h = &st1;
    cout << "student\n";
    cout << h->calculate_income() << endl;
    employee emp1("saba nasr", 1234, "girl", 1000000, 16);
    h = &emp1;
    cout << "employee\n";
    cout << h->calculate_tax() << " " << h->calculate_income() << endl;
    h->cost(100000);
    cout << "income after cost: " << h->pay_salary() << endl;
    professor pr("hossein yavari", 3245325, "man", "ostadyar", 87, 10);
    h = &pr;
    cout << "professor\n";
    cout << "salary: " << h->calculate_income() << " " << "Tax: " << h->calculate_tax() << endl;
    h->cost(2000000);
    cout << "income after cost: " << h->pay_salary() << endl;
    partTimeEmployee partEmp1("hamid askari", 1234234, "man", 1000000, 12, 20);
    h = &partEmp1;
    cout << "partTime employee\n";
    cout << "salary: " << h->calculate_income() << " " << "Tax: " << h->calculate_tax() << endl;
    cout << "income after pay salary: " << h->pay_salary() << endl;
    cout << "income after cost: " << h->cost(20000) << endl;
    student_with_job stJOb1("mahsa amini", 1223354, "girl", 3000000, 9824516, 15);
    h =(student*) &stJOb1;
    cout << "student with job\n";
    cout << "salary: " << h->calculate_income() << " " << "Tax: " << h->calculate_tax() << endl;
    cout << "income after pay salary: " << h->pay_salary() << endl;
    cout << "income after cost: " << h->cost(20000) << endl;

    return 0;
}