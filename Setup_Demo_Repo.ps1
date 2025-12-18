# Setup_Demo_Repo.ps1
# Python Calculator Demo Setup
# Configures a repo with 'add', 'subtract' and conflicting 'multiply'/'divide' branches.

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

Write-Host "Setting up Calculator Demo in: $ScriptDir" -ForegroundColor Cyan

# 1. CAPTURE REMOTE (Improves Reset Flow)
$GenericRemote = ""
if (Test-Path ".git") {
    try {
        $GenericRemote = git remote get-url origin 2>$null
        if ($GenericRemote) { Write-Host "Found existing remote origin: $GenericRemote" -ForegroundColor Green }
    } catch {
        Write-Host "No existing remote found (or error reading it)." -ForegroundColor DarkGray
    }
    
    # 2. CLEANUP
    Write-Host "Removing existing .git directory to start fresh..."
    Remove-Item -Path ".git" -Recurse -Force
}

# Remove project folders if they exist
$OldFolders = @("shared", "client", "server", "ml_engine")
foreach ($F in $OldFolders) { if (Test-Path $F) { Remove-Item $F -Recurse -Force } }

# 3. INITIALIZE & MAIN BRANCH (Add)
Write-Host "Initializing repo & Main Branch..."
git init --quiet
if ($GenericRemote) {
    Write-Host "Restoring remote origin..."
    git remote add origin $GenericRemote
}
git checkout -b main --quiet

$MainCode = @"
def add(x, y):
    return x + y

def main():
    print("Simple Calculator")
    print("1. Add")
    
    choice = input("Enter choice(1): ")
    
    if choice == '1':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} + {num2} = {add(num1, num2)}")
    else:
        print("Invalid Input")

if __name__ == "__main__":
    main()
"@
$MainCode | Set-Content -Path "calculator.py" -Encoding UTF8

# Add all files (calculator.py, README.md, SCENARIO_WALKTHROUGH.md, Setup_Demo_Repo.ps1)
git add .
git commit -m "feat: Initial calculator and documentation" --quiet

# 3. INTEGRATION BRANCH (Subtract)
Write-Host "Creating Integration Branch..."
git checkout -b integration main --quiet

$IntegrationCode = @"
def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def main():
    print("Simple Calculator")
    print("1. Add")
    print("2. Subtract")
    
    choice = input("Enter choice(1/2): ")
    
    if choice == '1':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} + {num2} = {add(num1, num2)}")
    elif choice == '2':
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        print(f"{num1} - {num2} = {subtract(num1, num2)}")
    else:
        print("Invalid Input")

if __name__ == "__main__":
    main()
"@
$IntegrationCode | Set-Content -Path "calculator.py" -Encoding UTF8
git add calculator.py
git commit -m "feat: Add Subtract function" --quiet

# 4. FEATURE: MULTIPLY (User A)
Write-Host "Creating feat/multiply (User A)..."
git checkout -b feat/multiply integration --quiet

$MultiplyCode = @"
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
"@
$MultiplyCode | Set-Content -Path "calculator.py" -Encoding UTF8
git add calculator.py
git commit -m "feat: Add Multiply function" --quiet

# 5. FEATURE: DIVIDE (User B - CONFLICT!)
Write-Host "Creating feat/divide (User B)..."
git checkout integration --quiet
git checkout -b feat/divide integration --quiet

# Note: Uses '3. Divide' to conflict with '3. Multiply'
$DivideCode = @"
def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def divide(x, y):
    if y == 0:
        return "Error! Division by zero."
    return x / y

def main():
    print("Simple Calculator")
    print("1. Add")
    print("2. Subtract")
    print("3. Divide")
    
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
        print(f"{num1} / {num2} = {divide(num1, num2)}")
    else:
        print("Invalid Input")

if __name__ == "__main__":
    main()
"@
$DivideCode | Set-Content -Path "calculator.py" -Encoding UTF8
git add calculator.py
git commit -m "feat: Add Divide function" --quiet

# Return to main
git checkout main --quiet

Write-Host "`nSETUP COMPLETE!" -ForegroundColor Green
Write-Host "Repo reset with Python Calculator scenario."
