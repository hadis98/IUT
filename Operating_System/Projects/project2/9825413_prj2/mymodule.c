#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>        /* this is the file structure, file open read close */
#include <linux/cdev.h>      /* this is for character device, makes cdev avilable*/
#include <linux/semaphore.h> /* this is for the semaphore*/
#include <linux/uaccess.h>   /* this is for copy_user vice vers*/
#define GREEN "\033[32m"
#define DEVICENAME "mymodule"


int chardev_init(void);
void chardev_exit(void);

static int device_open(struct inode *, struct file *);
static int device_close(struct inode *, struct file *);
static ssize_t device_read(struct file *, char __user *, size_t, loff_t *);
static ssize_t device_write(struct file *, const char __user *, size_t, loff_t *);

int transaction(char[], int);
int enteghal_transaction(char[], int);
int variz_transaction(char[], int);
int bardasht_transaction(char[], int);
int myAtoi(const char *);

static int users[100];

struct semaphore sem;

struct cdev *mcdev; /* this is the name of my char driver that i will be registering*/
int major_number;   /* will store the major number extracted by dev_t*/
int ret;            /* used to return values*/
dev_t dev_num;      /* will hold the major number that the kernel gives*/

/* inode reffers to the actual file on disk*/

struct file_operations fops = {
    .owner = THIS_MODULE,   /* prevents unloading when operations are in use*/
    .open = device_open,    /* to open the device*/
    .write = device_write,  /* to write to the device*/
    .read = device_read,    /* to read the device*/
    .release = device_close /* to close the device*/
};

int chardev_init(void)
{
    /* we will get the major number dynamically*/
    ret = alloc_chrdev_region(&dev_num, 0, 1, DEVICENAME);
    if (ret < 0)
    {
        printk(KERN_ALERT " mymodule : failed to allocate major number\n");
        return ret;
    }
    else
        printk(" mymodule : mjor number allocated succesful\n");
    major_number = MAJOR(dev_num);
    printk(KERN_INFO "mymodule : major number of our device is %d\n", major_number);
    printk(KERN_INFO "mymodule : to use mknod /dev/%s c %d 0\n", DEVICENAME, major_number);

    mcdev = cdev_alloc(); /* create, allocate and initialize our cdev structure*/
    mcdev->ops = &fops;   /* fops stand for our file operations*/
    mcdev->owner = THIS_MODULE;

    ret = cdev_add(mcdev, dev_num, 1);
    if (ret < 0)
    {
        printk(KERN_ALERT "mymodule : device adding to the kerknel failed\n");
        return ret;
    }
    else
        printk("mymodule : device additin to the kernel succesful\n");

    for (int i = 0; i < 100; i++)
    {
        users[i] = 2000000;
    }

    sema_init(&sem, 1); /* initial value to one*/
    return 0;
}

void chardev_exit(void)
{
    cdev_del(mcdev); /*removing the structure that we added previously*/
    printk(KERN_INFO " mymodule : removed the mcdev from kernel\n");
    unregister_chrdev_region(dev_num, 1);
    printk(KERN_INFO " mymodule : unregistered the device numbers\n");
    printk(KERN_ALERT " mymodule : character driver is exiting\n");
}

static int device_open(struct inode *inode, struct file *filp)
{
    if (down_interruptible(&sem) != 0)
    {
        printk(KERN_ALERT "mymodule : the device has been opened by some \
                                        other device, unable to open lock\n");
        return -1;
    }
    printk("mymodule : device opened succesfully\n");
    return 0;
}

static ssize_t device_read(struct file *fp, char __user *buff, size_t length, loff_t *ppos)
{

    char data[2000];
    int counter = 0, sum = 0;
    printk("in device read\n");
    for (int i = 0; i < 100; i++)
    {
        sum += users[i];
    }
    printk("sum of all balances = %ld\n", sum);
    memset(data, 0, 2000 * sizeof(char));
    for (int i = 0; i < 100; i++)
    {
        sprintf(data, "%s%d,", data, users[i]);
        counter++;
    }
    int messagelen = strlen(data);
    printk("message size:%d number of users %d", messagelen, counter);
    printk("data \n %s\n", data);
    if (length > messagelen)
    {
        length = messagelen;
    }
    printk("length = %ld\n", length);
    if (copy_to_user(buff, data, length))
    {
        return -EFAULT;
    }

    return length;
}

static ssize_t device_write(struct file *fp, const char __user *buff, size_t length, loff_t *ppos)
{
    int maxdatalen = 30, ncopied;
    char databuf[maxdatalen];
    printk("in device write\n");
    printk("Writing device: \n");

    if (length < maxdatalen)
    {
        maxdatalen = length;
    }

    ncopied = copy_from_user(databuf, buff, maxdatalen);

    if (ncopied == 0)
    {
        printk("Copied %d bytes from the user\n", maxdatalen);
    }
    else
    {
        printk("Could't copy %d bytes from the user\n", ncopied);
    }

    databuf[maxdatalen] = 0;

    printk("Data from the user: %s\n", databuf);
    if (transaction(databuf, strlen(databuf))==1)
    {
        printk(GREEN "successfully updated\n\n");
    }
    else
    {
        printk(KERN_ALERT "couldn't update balances in %s instruction\n", databuf);
    }

    return length;
}

static int device_close(struct inode *inode, struct file *filp)
{
    up(&sem);
    printk(KERN_INFO "mymodule : device has been closed\n");
    return ret;
}

MODULE_DESCRIPTION("A BASIC CHAR DRIVER");
MODULE_LICENSE("GPL");

module_init(chardev_init);
module_exit(chardev_exit);

int transaction(char buffer[], int len_buffer)
{
    char command_type;
    command_type = buffer[0];
    if (len_buffer == 0)
    {
        // invalid
        printk(KERN_ALERT " wrong structure in transaction func");
        return -1;
    }
    else if (len_buffer == 1 && command_type == 'r')
    {
        for (int i = 0; i < 100; i++)
        {
            users[i] = 2000000;
        }
    }
    else if (len_buffer > 1)
    {
        if (command_type == 'e')
        {
            return 1 ? enteghal_transaction(buffer, len_buffer) == 1 : -1;
        }
        else if (command_type == 'v')
        {
            return 1 ? variz_transaction(buffer, len_buffer) == 1 : -1;
        }
        else if (command_type == 'b')
        {
            return 1 ? bardasht_transaction(buffer, len_buffer) == 1 : -1;
        }
        else
        {
            printk(KERN_ALERT " wrong structure in transaction func");
            return -1;
        }
    }
    else
    {
        printk(KERN_ALERT " wrong structure in transaction func");
        return -1;
    }
    return 1;
}

int enteghal_transaction(char buffer[], int len_buf)
{
    printk("in enteghal transaction\n");
    char temp[2];
    int nums[3];
    int index = 1, count = 0;
    char amount[100];
    int j = 0;
    while (count < 2)
    {
        if (buffer[index] >= '0' && buffer[index] <= '9')
        {
            if (buffer[index + 1] >= '0' && buffer[index + 1] <= '9' && buffer[index] != '0')
            {
                if (buffer[index + 2] >= '0' && buffer[index + 2] <= '9')
                {
                    printk(KERN_ALERT " wrong structure in enteghal func");
                    return -1;
                }
                temp[0] = buffer[index];
                temp[1] = buffer[index + 1];
                temp[2] = '\0';
                nums[count] = myAtoi(temp);
                index += 2;
                count++;
            }
            else if (buffer[index + 1] == ',')
            {
                nums[count] = (int)buffer[index] - 48;
                index++;
                count++;
            }
            else
            {
                printk(KERN_ALERT " wrong structure in enteghal func");
                return -1;
            }
        }
        else if (buffer[index] == ',' && buffer[index + 1] >= '0' && buffer[index + 1] <= '9')
        {
            index++;
        }
        else
        {
            printk(KERN_ALERT " wrong structure in enteghal func");
            return -1;
        }
    }

    for (int i = index + 1; i < len_buf; i++)
    {
        amount[j] = buffer[i];
        j++;
    }
    nums[2] = myAtoi(amount);
    if (users[nums[0]] - nums[2] < 0)
    {
        printk(KERN_ALERT "not enough balance in enteghal func");
        return -1;
    }
    users[nums[0]] = users[nums[0]] - nums[2];
    users[nums[1]] = users[nums[1]] + nums[2];
    return 1;
}

int variz_transaction(char buffer[], int len_buf)
{
    printk("in variz transaction\n");
    int amount_int, reciever, index = 5;
    char temp[2];
    char amount[100];
    int j = 0;
    if (buffer[0] != 'v' || buffer[1] != ',' || buffer[2] != '-' || buffer[3] != ',')
    { // invalid
        printk(KERN_ALERT " wrong structure in variz func");
        return -1;
    }
    if (buffer[4] >= '0' && buffer[4] <= '9')
    {
        if (buffer[5] >= '0' && buffer[5] <= '9' && buffer[4] != '0')
        {
            if (buffer[6] != ',')
            {
                return -1;
            }
            temp[0] = buffer[4];
            temp[1] = buffer[5];
            temp[2] = '\0';
            reciever = myAtoi(temp);
            index += 2;
        }
        else if (buffer[5] == ',')
        {
            reciever = (int)buffer[4] - 48;
            index++;
        }
        else
        {
            printk(KERN_ALERT " wrong structure in variz func");
            return -1;
        }
    }
    else
    {
        printk(KERN_ALERT " wrong structure in variz func");
        return -1;
    }

    for (int i = index; i < len_buf; i++)
    {
        amount[j] = buffer[i];
        j++;
    }
    amount_int = myAtoi(amount);
    users[reciever] = users[reciever] + amount_int;
    return 1;
}

int bardasht_transaction(char buffer[], int len_buf)
{
    printk("in bardasht transaction\n");
    int amount_int, reciever, index = 3;
    char temp[2];
    char amount[100];
    int j = 0;
    if (buffer[0] != 'b' || buffer[1] != ',')
    { // invalid
        printk(KERN_ALERT " wrong structure in bardasht func");
        return -1;
    }

    if (buffer[2] >= '0' && buffer[2] <= '9')
    {
        if (buffer[3] >= '0' && buffer[3] <= '9' && buffer[2] != '0')
        {
            if (buffer[4] != ',' || buffer[5] != '-' || buffer[6] != ',')
            {
                return -1;
            }
            temp[0] = buffer[2];
            temp[1] = buffer[3];
            temp[2] = '\0';
            reciever = myAtoi(temp);
            index = 7;
        }
        else if (buffer[3] == ',' && buffer[4] == '-' && buffer[5] == ',')
        {
            reciever = (int)buffer[2] - 48;
            index = 6;
        }
        else
        {
            printk(KERN_ALERT " wrong structure in bardasht func");
            return -1;
        }
    }
    else
    {
        printk(KERN_ALERT " wrong structure in bardasht func");
        return -1;
    }

    for (int i = index; i < len_buf; i++)
    {
        amount[j] = buffer[i];
        j++;
    }
    amount_int = myAtoi(amount);
    if (users[reciever] - amount_int < 0)
    {
        printk(KERN_ALERT "not enough balance in bardasht func");
        return -1;
    }
    users[reciever] = users[reciever] - amount_int;
    return 1;
}

int myAtoi(const char *str)
{
    int sign = 1, base = 0, i = 0;
    while (str[i] == ' ')
    {
        i++;
    }
    if (str[i] == '-' || str[i] == '+')
    {
        sign = 1 - 2 * (str[i++] == '-');
    }

    while (str[i] >= '0' && str[i] <= '9')
    {
        if (base > INT_MAX / 10 || (base == INT_MAX / 10 && str[i] - '0' > 7))
        {
            if (sign == 1)
                return INT_MAX;
            else
                return INT_MIN;
        }
        base = 10 * base + (str[i++] - '0');
    }
    return base * sign;
}
