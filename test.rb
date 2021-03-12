data = "---------- Forwarded message ---------
From: Wells Fargo Online <alerts@notify.wellsfargo.com>
Date: Mon, Mar 1, 2021, 5:18 PM
Subject: You received money with Zelle
To: <donofrio.felipe@gmail.com>


<https://www.wellsfargo.com>[image: Wells Fargo logo]
You received money with Zelle®
RAUL ASENSI FARINAS sent you money. Here are the details:
*Date * 03/01/2021
*Amount * $100.00
*Confirmation Code * RT09XMTXRD
This money has been deposited in your Wells Fargo account XXXXXX5516.

For more information, please call Wells Fargo Online Customer Service at
1-800-956-4442, 24 hours a day, 7 days a week.

*wellsfargo.com* <https://www.wellsfargo.com> | Security Center
<https://www.wellsfargo.com/privacy-security/fraud>
*Please do not reply to this automated email.* Sign on to send a secure
email
<https://connect.secure.wellsfargo.com/auth/login/present?origin=cob&loginMode=jukePassword&serviceType=askQuestion&LOB=CONS>
.
Transactions typically occur in minutes when the recipient's email address
or U.S. mobile number is already enrolled with *Zelle*. Available to almost
anyone with a U.S.-based bank account. For your protection, *Zelle* should
only be used for sending money to friends, family, or others you know and
trust. Sending money with *Zelle* is similar to making a payment in cash.
Your mobile carrier's message and data rates may apply.
"

puts data.match(/([A-Z]+\s[A-Z]+\s[A-Z]+\s[A-Z]{0,})/)

puts data.match(/(\d)+\/(\d)+\/(\d)+/)

puts data.match(/\$(\d+)\.(\d+)/)

puts data.match(/([0-9A-Z]){8,}/)
