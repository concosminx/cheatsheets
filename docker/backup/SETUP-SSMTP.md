# Configure `ssmtp` on Ubuntu to Send Email with Gmail

SSMTP (Simple SMTP) is a lightweight, command-line tool designed for Linux and similar Unix-like operating systems. Its primary purpose is to send emails from a local computer to an external mail server (or mail hub), such as Gmail's SMTP server.

This guide will walk you through setting up `ssmtp` on your Ubuntu server to send emails using your Gmail account. This is ideal for server notifications, cron job output, or simple application emails, without running a full-blown mail server.

---

## Prerequisites

Before you begin, ensure you have:

* An **Ubuntu server** (e.g., an OCI instance).
* A **Gmail account**.
* **2-Step Verification (2FA)** enabled on your Gmail account. This is a security requirement for generating App Passwords.
    * Go to [Google Account Security](https://myaccount.google.com/security).
    * Under "Signing in to Google," turn on "2-Step Verification."

---

## Step 1: Generate a Google App Password

If you have 2-Step Verification enabled, you **cannot** use your regular Gmail password directly. You need to generate a special **App Password**.

1.  Go to your Google Account: [https://myaccount.google.com/](https://myaccount.google.com/)
2.  Navigate to **Security** (left-hand menu).
3.  Under "Signing in to Google," click on **2-Step Verification**. You might need to re-enter your Google password.
4.  Scroll down to **App passwords**.
5.  If you have existing App Passwords for Mail, consider revoking them to avoid confusion.
6.  Generate a new App Password:
    * From the "Select app" dropdown, choose **Mail**.
    * From the "Select device" dropdown, choose **Other (Custom name)**.
    * Give it a descriptive name (e.g., `ssmtp-ubuntu-oci`).
    * Click the **Generate** button.
7.  Google will display a **16-character password** (e.g., `abcd efgh ijkl mnop`).
    ***IMPORTANT: Copy this password immediately! It will only be shown once. When you use this password in your configuration file, you MUST remove all spaces. So, `abcdefghijklmnop` is what you will paste.***

---

## Step 2: Install `ssmtp` and `mailutils`

`mailutils` provides the `mail` command, which is a convenient way to send emails using `ssmtp`.

```bash
sudo apt update
sudo apt install ssmtp mailutils
```

During installation, if prompted to configure `ssmtp`, you can usually select "Local only" or just let it proceed, as we'll be manually editing the configuration files.

## Step 3: Configure `ssmtp.conf`

This is the main configuration file for `ssmtp`. It tells `ssmtp` how to connect to Gmail's SMTP server and authenticate.

1.  Open the configuration file for editing:
    ```bash
    sudo nano /etc/ssmtp/ssmtp.conf
    ```

2.  Add or modify the following lines. **Replace `your_gmail_address@gmail.com` with your actual Gmail address and `YOUR_16_CHARACTER_APP_PASSWORD_WITHOUT_SPACES` with the App Password you generated (remembering to remove all spaces!).**

    ```ini
    # Default sender for system mail (e.g., root, cron jobs)
    root=your_gmail_address@gmail.com

    # Gmail's SMTP server and port 587 (for STARTTLS)
    mailhub=smtp.gmail.com:587

    # Your Gmail account for authentication
    AuthUser=your_gmail_address@gmail.com

    # Your App Password (16 characters, NO SPACES!)
    AuthPass=YOUR_16_CHARACTER_APP_PASSWORD_WITHOUT_SPACES

    # Enable TLS for secure connection
    UseTLS=YES
    UseSTARTTLS=YES

    # Allows users to specify their own "From" address (useful with revaliases)
    FromLineOverride=YES

    # The hostname ssmtp will present to the SMTP server.
    # Use 'localhost' if your server doesn't have a publicly resolvable FQDN.
    hostname=localhost
    ```

3.  Save the file (Press `Ctrl+X`, then `Y`, then `Enter`).

---

## Step 4: Configure `revaliases` (User Mappings)

The `revaliases` file maps local system users to specific email addresses for outgoing mail. This is useful if you want emails sent by users like `root` or `www-data` to appear as coming from your Gmail address.

1.  Open the `revaliases` file for editing:
    ```bash
    sudo nano /etc/ssmtp/revaliases
    ```

2.  Add lines in the following format for each local user that might send mail. Replace `your_gmail_address@gmail.com` with your actual Gmail address.

    ```
    # Format: local_username:external_email_address:mailhub:port

    # For the root user
    root:your_gmail_address@gmail.com:smtp.gmail.com:587

    # For your main Ubuntu user (replace 'your_ubuntu_username')
    your_ubuntu_username:your_gmail_address@gmail.com:smtp.gmail.com:587

    # For web server processes (e.g., Apache/Nginx if they send mail)
    www-data:your_gmail_address@gmail.com:smtp.gmail.com:587
    ```

3.  Save the file (Press `Ctrl+X`, then `Y`, then `Enter`).

---

## Step 5: Secure Configuration Files

Since `ssmtp.conf` contains your App Password, it's critical to restrict its access.

```bash
sudo chmod 644 /etc/ssmtp/ssmtp.conf
sudo chmod 644 /etc/ssmtp/revaliases
```

## Step 6: Test Your Configuration

After all the above steps, it's time to send a test email.

### a. Test with `ssmtp` (for verbose output and debugging)

This is the best way to see what's happening under the hood.

```bash
echo "This is a test email sent from your Ubuntu server using sSMTP and Gmail. If you see this, it worked!" | ssmtp -v recipient@example.com
```

Replace `recipient@example.com` with an email address you can check. The `-v` flag will give you detailed output of the SMTP conversation.

### b. Test with `mail` (for simple sending)

Once `ssmtp` is working, you can use the `mail` command for simple email sending.

```bash
echo "Hello from your Ubuntu server! This is a test email sent via 'mail' command with sSMTP and Gmail." | mail -s "Ubuntu Server Mail Test" -r your_gmail_address@gmail.com recipient@example.com
```

* Replace `your_gmail_address@gmail.com` with the actual Gmail address you're authenticating with.

* Replace `recipient@example.com` with the email address you want to send the test to.

* The `-r` flag ensures the "From" header is correctly set (matching your `AuthUser`).

If the command executes without any errors displayed, check the recipient's inbox (including spam/junk folders).
