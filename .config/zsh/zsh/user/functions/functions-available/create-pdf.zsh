#shellcheck disable=2148


function create_pdf(){
	local TEXT
	TEXT="${1:-EXAMPLE TEXT}"

	cat << EOF
%PDF-1.1

1 0 obj
<< /Type /Catalog
/Pages 2 0 R
>>
endobj

2 0 obj
<< /Type /Pages
/Kids [3 0 R]
/Count 1
/MediaBox [0 0 595 842]
>>
endobj

3 0 obj
<<  /Type /Page
/Parent 2 0 R
/Resources
<< /Font
<< /F1
<< /Type /Font
/Subtype /Type1
/BaseFont /Times-Roman
>>
>>
>>
/Contents 4 0 R
>>
endobj

4 0 obj
<< /Length 48 >>
stream
BT
/F1 72 Tf
55 460 Td
(${TEXT}) Tj
ET
endstream
endobj

xref
0 5
0000000000 65535 f
0000000016 00000 n
0000000066 00000 n
0000000148 00000 n
0000000303 00000 n
trailer
<<  /Root 1 0 R
/Size 5
>>
startxref
402
%%EOF
EOF

}
