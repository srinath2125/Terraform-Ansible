project_id = "vpc-peering-453205"
region     = "asia-south1"

vm_instances = [
  {
    name         = "web-server"
    machine_type = "e2-medium"
    zone         = "asia-south1-b"
    image        = "ubuntu-os-cloud/ubuntu-2204-lts"
  }
]

ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCbGHT2iQeKjBCLhIPW1UTBexkN6QCpXsOkBmfVBZpfZk+2rVPF8R+jMmOZjZzG2rpub8KTsRCWIZRZSv65cZw/FXRiA1z4WvCPszNxGuk1r/UI6jD6BIojB/TJINpOjMDvD/J7xwVKRAX9XHMsoKEzPbZlHZ8eCQsPuGBTGaw2Ife7zQLmzCJJnRk6/eep7wyyKRNijvli5y75pLJj01enzor59eNWdlDn4j4EDDU5IhFFdQwW4QBazV9iDhp5yM3w5sDmPSD1ha/rY49SKj+vEQZtJrjtEPxut7qr08A1iMtLGTRUBjEPoXgk02u0R2C5ejPpeSii+XkOycr81ukEDJDyEAaoHiIXA5PelAlJ3Lnjw3D6wCF4sGPLBI80mY7RSENhB9idAPLQ25y8BPOMCM+n6FSGXc8/l5aYZc8iz++1ph5Rp3WBkn5tkLtuB7a0l9rxIQF7bfxbTZOxKMPPbcJ0c3rpjq0tXo98vd973oAnmTPleKUT9Ic1WlKxoFqlloh6/RXfZgU/Ch+FtuHHjrMUXwRgEXnWjSArG7gSSEDyCTJsVCHNfGFzO3lHugGhy06VSwMAr69w+Pd69ct8WYj/yYiDg5uFytiZCLqRABZoFO2plA4ZqDQEKM0Ym46c3cHUo8lRHC15c5Fb7gOLx+K0dA0MLyyt86UKQXnqBQ== chran256deep@gmail.com" # Replace with your actual SSH public key
