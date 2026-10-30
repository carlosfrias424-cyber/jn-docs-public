#!/bin/bash
set -e
cd ~/jn-docs || mkdir -p ~/jn-docs && cd ~/jn-docs

python3 -m venv /tmp/pdfvenv
/tmp/pdfvenv/bin/pip install -q reportlab

cat > /tmp/make_docs.py << 'EOF'
from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, HRFlowable
from reportlab.lib.enums import TA_RIGHT, TA_CENTER

def styles():
    s = getSampleStyleSheet()
    s.add(ParagraphStyle(name="Header", fontSize=16, leading=20, alignment=TA_CENTER, spaceAfter=6, fontName="Helvetica-Bold"))
    s.add(ParagraphStyle(name="SubHeader", fontSize=10, leading=13, alignment=TA_CENTER, spaceAfter=12, textColor=colors.HexColor("#333333")))
    s.add(ParagraphStyle(name="Label", fontSize=9, leading=12, fontName="Helvetica-Bold", textColor=colors.HexColor("#444444")))
    s.add(ParagraphStyle(name="Body", fontSize=10, leading=13, fontName="Helvetica"))
    s.add(ParagraphStyle(name="Right", fontSize=10, leading=13, alignment=TA_RIGHT, fontName="Helvetica"))
    s.add(ParagraphStyle(name="Total", fontSize=12, leading=15, alignment=TA_RIGHT, fontName="Helvetica-Bold"))
    s.add(ParagraphStyle(name="Footer", fontSize=8, leading=10, alignment=TA_CENTER, textColor=colors.HexColor("#666666")))
    return s

def footer(story, s):
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#aaaaaa"), spaceBefore=8))
    story.append(Paragraph("Noble Guard Roofing &nbsp;\u00b7&nbsp; Honor Above. Protection Below. &nbsp;\u00b7&nbsp; carlos@nobleguardroofing.com", s["Footer"]))

# ===== ESTIMATE =====
doc = SimpleDocTemplate("Ace-Welding-Estimate-1038.pdf", pagesize=letter, rightMargin=0.7*inch, leftMargin=0.7*inch, topMargin=0.6*inch, bottomMargin=0.6*inch)
s = styles()
story = []
story.append(Paragraph("ESTIMATE", s["Header"]))
story.append(Paragraph("Noble Guard Roofing &nbsp;|&nbsp; Top Tier Finish, Inc.", s["SubHeader"]))
story.append(HRFlowable(width="100%", thickness=1, color=colors.HexColor("#222222"), spaceAfter=12))
meta = [
    [Paragraph("<b>Estimate #:</b>", s["Body"]), Paragraph("1038", s["Body"]),
     Paragraph("<b>Date:</b>", s["Body"]), Paragraph("October 30, 2026", s["Body"])],
    [Paragraph("<b>Job:</b>", s["Body"]), Paragraph("Ace Welding Spring Jail", s["Body"]),
     Paragraph("<b>Prepared For:</b>", s["Body"]), Paragraph("Customer", s["Body"])],
    [Paragraph("<b>Project:</b>", s["Body"]), Paragraph("Spring Jail Roofing", s["Body"]),
     Paragraph("<b>Status:</b>", s["Body"]), Paragraph("Current", s["Body"])],
]
t = Table(meta, colWidths=[1.3*inch, 2.4*inch, 1.3*inch, 2.4*inch])
t.setStyle(TableStyle([("VALIGN",(0,0),(-1,-1),"TOP"),("BOTTOMPADDING",(0,0),(-1,-1),4),("TOPPADDING",(0,0),(-1,-1),2)]))
story.append(t)
story.append(Spacer(1,16))
story.append(Paragraph("PROPOSED WORK", s["Label"]))
story.append(Spacer(1,6))
items = [
    [Paragraph("<b>Description</b>", s["Body"]), Paragraph("<b>Amount</b>", s["Body"])],
    [Paragraph("Roofing scope \u2014 Ace Welding Spring Jail", s["Body"]), Paragraph("$4,775.00", s["Right"])],
]
it = Table(items, colWidths=[5.5*inch, 1.5*inch])
it.setStyle(TableStyle([
    ("BACKGROUND",(0,0),(-1,0),colors.HexColor("#f0f0f0")),
    ("FONTNAME",(0,0),(-1,0),"Helvetica-Bold"),
    ("ALIGN",(1,0),(1,-1),"RIGHT"),
    ("VALIGN",(0,0),(-1,-1),"MIDDLE"),
    ("GRID",(0,0),(-1,-1),0.5,colors.HexColor("#cccccc")),
    ("BOTTOMPADDING",(0,0),(-1,-1),8),("TOPPADDING",(0,0),(-1,-1),8),
    ("LEFTPADDING",(0,0),(-1,-1),6),("RIGHTPADDING",(0,0),(-1,-1),6),
]))
story.append(it)
story.append(Spacer(1,8))
tot = Table([[Paragraph("<b>TOTAL</b>", s["Total"]), Paragraph("<b>$4,775.00</b>", s["Total"])]], colWidths=[5.5*inch, 1.5*inch])
tot.setStyle(TableStyle([("ALIGN",(1,0),(1,0),"RIGHT"),("LINEABOVE",(0,0),(-1,0),1.5,colors.HexColor("#222222")),("TOPPADDING",(0,0),(-1,-1),8)]))
story.append(tot)
story.append(Spacer(1,20))
story.append(Paragraph("NOTES", s["Label"]))
story.append(Spacer(1,4))
story.append(Paragraph("Customer estimate for Ace Welding Spring Jail roofing work. Corresponding work order to subcontractor is separate.", s["Body"]))
footer(story, s)
doc.build(story)
print("Wrote Ace-Welding-Estimate-1038.pdf")

# ===== WORK ORDER =====
doc = SimpleDocTemplate("Ace-Welding-WorkOrder-1010-UPDATED.pdf", pagesize=letter, rightMargin=0.7*inch, leftMargin=0.7*inch, topMargin=0.6*inch, bottomMargin=0.6*inch)
s = styles()
story = []
story.append(Paragraph("WORK ORDER", s["Header"]))
story.append(Paragraph("Noble Guard Roofing &nbsp;|&nbsp; Top Tier Finish, Inc.", s["SubHeader"]))
story.append(HRFlowable(width="100%", thickness=1, color=colors.HexColor("#222222"), spaceAfter=12))
meta = [
    [Paragraph("<b>Work Order #:</b>", s["Body"]), Paragraph("1010", s["Body"]),
     Paragraph("<b>Date:</b>", s["Body"]), Paragraph("October 30, 2026", s["Body"])],
    [Paragraph("<b>Job:</b>", s["Body"]), Paragraph("Ace Welding Spring Jail", s["Body"]),
     Paragraph("<b>Subcontractor:</b>", s["Body"]), Paragraph("See job record", s["Body"])],
    [Paragraph("<b>Project:</b>", s["Body"]), Paragraph("Spring Jail Roofing", s["Body"]),
     Paragraph("<b>Status:</b>", s["Body"]), Paragraph("Updated", s["Body"])],
]
t = Table(meta, colWidths=[1.4*inch, 2.3*inch, 1.4*inch, 2.3*inch])
t.setStyle(TableStyle([("VALIGN",(0,0),(-1,-1),"TOP"),("BOTTOMPADDING",(0,0),(-1,-1),4),("TOPPADDING",(0,0),(-1,-1),2)]))
story.append(t)
story.append(Spacer(1,16))
story.append(Paragraph("SCOPE OF WORK", s["Label"]))
story.append(Spacer(1,6))
items = [
    [Paragraph("<b>Description</b>", s["Body"]), Paragraph("<b>Amount</b>", s["Body"])],
    [Paragraph("Roofing work \u2014 Ace Welding Spring Jail (original scope)", s["Body"]), Paragraph("$2,500.00", s["Right"])],
    [Paragraph("Additional: Building 2504 leak repair", s["Body"]), Paragraph("$250.00", s["Right"])],
]
it = Table(items, colWidths=[5.5*inch, 1.5*inch])
it.setStyle(TableStyle([
    ("BACKGROUND",(0,0),(-1,0),colors.HexColor("#f0f0f0")),
    ("FONTNAME",(0,0),(-1,0),"Helvetica-Bold"),
    ("ALIGN",(1,0),(1,-1),"RIGHT"),
    ("VALIGN",(0,0),(-1,-1),"MIDDLE"),
    ("GRID",(0,0),(-1,-1),0.5,colors.HexColor("#cccccc")),
    ("BOTTOMPADDING",(0,0),(-1,-1),8),("TOPPADDING",(0,0),(-1,-1),8),
    ("LEFTPADDING",(0,0),(-1,-1),6),("RIGHTPADDING",(0,0),(-1,-1),6),
]))
story.append(it)
story.append(Spacer(1,8))
tot = Table([[Paragraph("<b>TOTAL</b>", s["Total"]), Paragraph("<b>$2,750.00</b>", s["Total"])]], colWidths=[5.5*inch, 1.5*inch])
tot.setStyle(TableStyle([("ALIGN",(1,0),(1,0),"RIGHT"),("LINEABOVE",(0,0),(-1,0),1.5,colors.HexColor("#222222")),("TOPPADDING",(0,0),(-1,-1),8)]))
story.append(tot)
story.append(Spacer(1,20))
story.append(Paragraph("NOTES", s["Label"]))
story.append(Spacer(1,4))
story.append(Paragraph("Updated work order. Includes original scope plus additional leak repair at Building 2504. Subcontractor payment per this total.", s["Body"]))
footer(story, s)
doc.build(story)
print("Wrote Ace-Welding-WorkOrder-1010-UPDATED.pdf")
EOF

/tmp/pdfvenv/bin/python /tmp/make_docs.py
ls -la ~/jn-docs/Ace-Welding-*.pdf
