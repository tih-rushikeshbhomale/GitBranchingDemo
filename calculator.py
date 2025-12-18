def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def multiply(x, y):
    return x * y

def main():
    print("Simple Calculator")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    
    choice = input("Enter choice(1/2/3): ")
    
    if choice == '1':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} + {num2} = {add(num1, num2)}")
    elif choice == '2':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} - {num2} = {subtract(num1, num2)}")
    elif choice == '3':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} * {num2} = {multiply(num1, num2)}")
    else:
        print("Invalid Input")

if __name__ == "__main__":
    main()
