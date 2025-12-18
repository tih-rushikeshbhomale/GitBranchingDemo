# Git Workflow Demo: Python Calculator

This demo shows how multiple developers contribute features to a shared `calculator.py` program.

## 🎭 The Scenario

-   **Base State**: `integration` branch has **Add** and **Subtract**.
-   **User A**: Adds **Multiply** (Branch: `feat/multiply`).
-   **User B**: Adds **Divide** (Branch: `feat/divide`).

**The Conflict**: Both users add their new option as **"Item 3"** in the menu. When you try to merge both, Git won't know which "Item 3" is correct!

---

## ✅ Phase 1: Setup

### Setting up from scratch
1.  Open terminal in `d:\SampleRepo\GitBranchingDemo`.
2.  Run: `.\Setup_Demo_Repo.ps1`
3.  **GitHub Setup**:
    -   Create a NEW empty repo on GitHub.
    -   Run:
        ```powershell
        git remote remove origin
        git remote add origin <YOUR_GITHUB_URL>
        git push -u origin --all
        ```

### Attendee (Following along)
1.  Go to the Presenter's GitHub Repository.
2.  Click **Fork** (top right).
3.  **IMPORTANT**: On the Create Fork page, **UNCHECK** "Copy the `main` branch only".
    -   *Why?* We need the extra branches (`feat/multiply`, `feat/divide`) to exist in your fork so you can create the Pull Requests.
    -   *Note: Do NOT use "Use this template". It deletes branches.*
4.  **Clone to Local** (Required for Track B Only):
    -   If you plan to use **Track B** (VS Code / Local), run this now:
    ```powershell
    # Replace with YOUR fork URL
    git clone https://github.com/<YOUR_USERNAME>/GitBranchingDemo.git
    cd GitBranchingDemo
    ```
5.  **Skip to Phase 2**.


---

## 🚀 Phase 2: The Demo Flow

### Step 1: Merge 'Multiply' (Clean)
*(Both tracks do this part via Web for speed)*
1.  Go to GitHub -> **v New Pull Request**.
2.  **Base**: `integration` | **Compare**: `feat/multiply`.
3.  **Create** and **Merge** the Pull Request.
    -   *Now `integration` has the Multiply feature (Item 3).*


### Step 2: Merge 'Divide' (The Conflict)

Now we have a conflict! `feat/divide` conflicts with the new `integration` (which has `multiply`).
**Choose your resolution path:**

#### 🅰 Track A: GitHub Web Editor (Easiest)
1.  Create **New Pull Request**: **Base**: `integration` | **Compare**: `feat/divide`.
2.  **Conflict Alert!** Click **"Resolve conflicts"**.
3.  **Fix**:
    -   Keep both functions.
    -   Renumber "3. Divide" to **"4. Divide"**.
    -   Remove markers `<<<<`, `====`, `>>>>`.
4.  **Mark as resolved** -> **Commit merge**.
5.  **Merge Pull Request**.

#### 🅱 Track B: Local VS Code (Realistic Developer Flow)
*Prerequisite: You must have cloned your repo locally.*

1.  **Checkout the feature branch**:
    ```powershell
    git checkout feat/divide
    ```
2.  **Try to update from integration** (simulation of pulling latest changes):
    ```powershell
    git pull origin integration
    ```
    *Output: "CONFLICT (content): Merge conflict in calculator.py"*
3.  **Resolve Locally**:
    -   Open `calculator.py` in your editor (VS Code recommended).
    -   *Note: VS Code detects conflicts automatically. You don't need special extensions. You can click "Accept Current Change" etc., or just edit the text manually.*
    -   Fix the conflict (Rename Divide to 4, keep markers clean).
    -   Save the file.
4.  **Commit and Push**:
    ```powershell
    git add calculator.py
    git commit -m "fix: Resolve merge conflict with integration"
    git push origin feat/divide
    ```
5.  **Create PR**:
    -   Go to GitHub.
    -   Create Pull Request for `feat/divide`.
    -   **Result**: It shows *Able to merge* (Green). No conflicts!
6.  **Merge Pull Request**.


---

## 🔁 Reset
To try again:
1.  Run `.\Setup_Demo_Repo.ps1`
    -   *Note: The script tries to preserve your remote URL. If it says "Restoring remote origin...", you can skip to step 3.*
2.  If the script didn't find the remote (or it's your first run), add it:
    ```powershell
    git remote add origin <YOUR_GITHUB_URL>
    ```
3.  **Force Push** to reset GitHub:
    ```powershell
    git push --force --all origin
    ```
