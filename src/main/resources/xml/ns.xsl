<?xml version="1.0" ?>

<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0"
     xmlns:os='https://moise-exceptions.sourceforge.io/os'
>
<xsl:output encoding="ISO-8859-1" method="html" />
<xsl:include href="os.xsl" />

<xsl:template match="/">
   <html>
      <body>
         <xsl:apply-templates select="os:organisational-specification/os:normative-specification" />
      </body>
   </html>
</xsl:template>


</xsl:stylesheet>

