echo 'Prova 32 IP'
cd $HOME
source export.sh
cd program_fpga
./program_fpga.sh -f ../Bitstreams/prova31m.bit
cd ../dma_ip_drivers-2020.1/XDMA/linux-kernel/tools/
echo 'Clearing the HBM...'
sudo ./dma_to_device -f clearHBM.bin -a 0x0 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x10000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x20000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x30000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x40000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x50000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x60000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x70000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x80000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x90000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xA0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xB0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xC0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xD0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xE0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0xF0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x100000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x110000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x120000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x130000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x140000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x150000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x160000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x170000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x180000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x190000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1A0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1B0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1C0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1D0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1E0000000 -s 67108860
sudo ./dma_to_device -f clearHBM.bin -a 0x1F0000000 -s 67108860


echo 'Reading HBM...'
sudo ./dma_from_device -f Prova -a 0x00000000 -s 512 && hexdump Prova


echo 'Configuring the HLS IP 0'
echo 'Setting the address...'
echo "00000000: 0000 0080" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200200010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20020001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200200004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200200008 -s 4

echo 'Configuring the HLS IP 1'
echo 'Setting the address...'
echo "00000000: 0000 0030" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200210010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20021001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200210004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200210008 -s 4

echo 'Configuring the HLS IP 2'
echo 'Setting the address...'
echo "00000000: 0000 0030 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002c0010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002c001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002c0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002c0008 -s 4

echo 'Configuring the HLS IP 3'
echo 'Setting the address...'
echo "00000000: 0000 00d0 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200370010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20037001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200370004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200370008 -s 4

echo 'Configuring the HLS IP 4'
echo 'Setting the address...'
echo "00000000: 0000 00b0 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200390010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20039001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200390004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200390008 -s 4

echo 'Configuring the HLS IP 5'
echo 'Setting the address...'
echo "00000000: 0000 0000 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2003a0010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2003a001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2003a0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2003a0008 -s 4

echo 'Configuring the HLS IP 6'
echo 'Setting the address...'
echo "00000000: 0000 00a0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2003b0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2003b001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2003b0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2003b0008 -s 4

echo 'Configuring the HLS IP 7'
echo 'Setting the address...'
echo "00000000: 0000 00e0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2003c0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2003c001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2003c0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2003c0008 -s 4

echo 'Configuring the HLS IP 8'
echo 'Setting the address...'
echo "00000000: 0000 0070" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2003d0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2003d001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2003d0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2003d0008 -s 4

echo 'Configuring the HLS IP 9'
echo 'Setting the address...'
echo "00000000: 0000 00a0 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2003e0010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2003e001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2003e0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2003e0008 -s 4

echo 'Configuring the HLS IP 10'
echo 'Setting the address...'
echo "00000000: 0000 00d0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200220010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20022001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200220004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200220008 -s 4

echo 'Configuring the HLS IP 11'
echo 'Setting the address...'
echo "00000000: 0000 0040 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200230010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20023001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200230004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200230008 -s 4

echo 'Configuring the HLS IP 12'
echo 'Setting the address...'
echo "00000000: 0000 00c0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200240010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20024001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200240004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200240008 -s 4

echo 'Configuring the HLS IP 13'
echo 'Setting the address...'
echo "00000000: 0000 0080 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200250010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20025001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200250004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200250008 -s 4

echo 'Configuring the HLS IP 14'
echo 'Setting the address...'
echo "00000000: 0000 0090 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200260010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20026001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200260004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200260008 -s 4

echo 'Configuring the HLS IP 15'
echo 'Setting the address...'
echo "00000000: 0000 0060" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200270010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20027001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200270004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200270008 -s 4

echo 'Configuring the HLS IP 16'
echo 'Setting the address...'
echo "00000000: 0000 0020 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200280010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20028001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200280004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200280008 -s 4

echo 'Configuring the HLS IP 17'
echo 'Setting the address...'
echo "00000000: 0000 0070 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200290010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20029001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200290004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200290008 -s 4

echo 'Configuring the HLS IP 18'
echo 'Setting the address...'
echo "00000000: 0000 0040" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002a0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002a001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002a0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002a0008 -s 4

echo 'Configuring the HLS IP 19'
echo 'Setting the address...'
echo "00000000: 0000 0020" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002b0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002b001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002b0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002b0008 -s 4

echo 'Configuring the HLS IP 20'
echo 'Setting the address...'
echo "00000000: 0000 0000" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002d0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002d001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002d0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002d0008 -s 4

echo 'Configuring the HLS IP 21'
echo 'Setting the address...'
echo "00000000: 0000 0060 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002e0010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002e001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002e0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002e0008 -s 4

echo 'Configuring the HLS IP 22'
echo 'Setting the address...'
echo "00000000: 0000 0090" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x2002f0010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x2002f001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x2002f0004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x2002f0008 -s 4

echo 'Configuring the HLS IP 23'
echo 'Setting the address...'
echo "00000000: 0000 00e0 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200300010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20030001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200300004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200300008 -s 4

echo 'Configuring the HLS IP 24'
echo 'Setting the address...'
echo "00000000: 0000 00c0 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200310010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20031001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200310004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200310008 -s 4

echo 'Configuring the HLS IP 25'
echo 'Setting the address...'
echo "00000000: 0000 0010 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200320010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20032001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200320004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200320008 -s 4

echo 'Configuring the HLS IP 26'
echo 'Setting the address...'
echo "00000000: 0000 0050 0100" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200330010 -s 6
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20033001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200330004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200330008 -s 4

echo 'Configuring the HLS IP 27'
echo 'Setting the address...'
echo "00000000: 0000 0050" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200340010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20034001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200340004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200340008 -s 4

echo 'Configuring the HLS IP 28'
echo 'Setting the address...'
echo "00000000: 0000 0010" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200350010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20035001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200350004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200350008 -s 4

echo 'Configuring the HLS IP 29'
echo 'Setting the address...'
echo "00000000: 0000 00b0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200360010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20036001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200360004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200360008 -s 4

echo 'Configuring the HLS IP 30'
echo 'Setting the address...'
echo "00000000: 0000 00f0" | xxd -r - temp.bin
sudo ./dma_to_device -f temp.bin -a 0x200380010 -s 4
echo 'Setting the size...'
sudo ./dma_to_device -f send256MB.bin -a 0x20038001c -s 4

#echo 'Choosing the read operation...'
#dovrebbe essere già 0
echo 'Global Interrupt enable'
sudo ./dma_to_device -f bit0High.bin -a 0x200380004 -s 4
echo 'Chosing the ap_done interrupt'
sudo ./dma_to_device -f bit0High.bin -a 0x200380008 -s 4



echo 'Starting the HLS IPs...'
# sudo ./dma_to_device -f bit0High.bin -a 0x200200000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200210000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002c0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200370000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200390000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2003a0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2003b0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2003c0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2003d0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2003e0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200220000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200230000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200240000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200250000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200260000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200270000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200280000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200290000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002a0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002b0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002d0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002e0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x2002f0000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200300000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200310000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200320000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200330000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200340000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200350000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200360000 -s 4
# sudo ./dma_to_device -f bit0High.bin -a 0x200380000 -s 4
sudo ./dma_to_device -f bit0High.bin -a 0x200200000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200210000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002c0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200370000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200390000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2003a0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2003b0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2003c0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2003d0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2003e0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200220000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200230000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200240000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200250000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200260000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200270000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200280000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200290000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002a0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002b0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002d0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002e0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x2002f0000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200300000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200310000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200320000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200330000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200340000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200350000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200360000 -s 4 & sudo ./dma_to_device -f bit0High.bin -a 0x200380000 -s 4

sleep 1

echo 'Reading from latency IPs...'
sudo ./dma_from_device -f Prova -a 0x200000000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200010000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000c0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200170000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200190000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2001a0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2001b0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2001c0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2001d0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2001e0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200020000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200030000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200040000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200050000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200060000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200070000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200080000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200090000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000a0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000b0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000d0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000e0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x2000f0000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200100000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200110000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200120000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200130000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200140000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200150000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200160000 -s 4 && hexdump Prova
sudo ./dma_from_device -f Prova -a 0x200180000 -s 4 && hexdump Prova

echo 'Reading HBM...'
sudo ./dma_from_device -f Prova -a 0x00000000 -s 512 && hexdump Prova


#echo "0000400: 4142 4344" | xxd -r - temp.bin
