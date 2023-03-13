#include <iostream>

int fact(int n)
{
    if(n == 1)
        return 1;
    return n * fact(n - 1);
}

int main()
{
    int out = fact(5);
    std::cout << out << std::endl;
    return 0;
}