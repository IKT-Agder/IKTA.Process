<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var"
                exclude-result-prefixes="msxsl var s1 ScriptNS0 userCSharp"
                version="1.0"
                xmlns:s1="http://IKTA.Common.Schemas.Internal.Fakturaer"
                xmlns:ns0="http://IKTA.Xledger.Schemas.v1_0.SO01b"
                xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s1:Fakturaer" />
  </xsl:template>
  <xsl:template match="/s1:Fakturaer">
    <ns0:SO01b>
      <Header>Entity Code;Imp System;Imp System Ref;Invoice Batch;Order No;Line No;Date;Customer No;Invoice Template;Ready To Invoice;Work Order;Project;Object;Object Value;Posting 1;Posting 2;XGL;Currency;Product;Product Item;XLG;Text (Imp);Pricelist;Price Group;Invoice Rule;Unit;Quantity;Cost Price;Unit Price;Discount % Imp;Discount Imp;Tax Rule;Prepaid To Bank ;Prepaid Date;Payment Ref;XIdentifier (KID);External Order Ref;Customer Name;Company No;Customer Group;Bank Account;Payment Terms;Update Address;Street Address 1;Street Address 2;Zip Code 1;Place;State;Country;InvoiceStreetAddress2Line1;InvoiceStreetAddress2Line2;InvoiceZipCode2;InvoiceCity2;InvoiceState2;InvoiceCountry2;Phone;E-mail;Language;Invoice Delivery Method;Invoice Layout;Your Ref;Ordered By;Our Sales Tmp;Our Ref Tmp;Contract;External GL;Period Start Tmp;Period Start Offset;No of Periods;Service Type;Tax Amount (VAT);Warehouse;Location;Header Info;Footer Info;Header Text Tmp;Footer Text Tmp;Dummy1;Dummy2;Dummy3;Dummy4;Dummy5;EOL</Header>
      <xsl:for-each select="Faktura">
        <xsl:variable name="fakturaIndex" select="position()" />
        <xsl:variable name="var:ImportingSystem" select="userCSharp:StripCRLF(string(/s1:Fakturaer/FraSystem/text()))" />
        <xsl:variable name="var:OrderNo" select="userCSharp:StripCRLF(string(Ordre/EksterntOrdreNummer/text()))" />
        <xsl:variable name="var:OriginalTransactionDate" select="TransaksjonsDato/text()" />
        <xsl:variable name="var:Date" select="userCSharp:FormatDate($var:OriginalTransactionDate, 'yyyyMMdd')" />

        <xsl:for-each select="Ordre/OrdreLinje">
          <xsl:variable name="var:numberOfAddressLines" select="count(/s1:Fakturaer/Faktura[$fakturaIndex]/FakturaMottaker/Adresse/AdresseLinje)" />
          <xsl:variable name="var:NumberOfInvoiceAddressLines" select="count(/s1:Fakturaer/Faktura[$fakturaIndex]/FakturaMottaker/FaktureringsAdresse/AdresseLinje)" />
          <xsl:variable name="var:LineNo" select="userCSharp:FormatWithLeadingZeroes(string(LinjeNummer/text()))" />

          <SO01bRecord>
            <xsl:variable name="var:InternalEntityCode" select="../../../Firma/text()" />
            <xsl:variable name="var:EntityCode" select="ScriptNS0:GetMappedValue(&quot;IKTA&quot; , &quot;Faktura.Firma&quot; , $var:InternalEntityCode , &quot;Xledger&quot; , &quot;SO01b.EntityCode&quot;)" />
            <xsl:variable select="userCSharp:StripCRLF(string(Produkt/text()))" name="var:Product"/>
            <xsl:variable select="userCSharp:StripCRLF(string(Beskrivelse/text()))" name="var:TextImp"/>
            <xsl:variable select="userCSharp:StripCRLF(string(Antall/text()))" name="var:Quantity"/>
            <xsl:variable select="userCSharp:StripCRLF(string(EnhetsPris/text()))" name="var:UnitPrice"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Fornavn/text()))" name="var:CustomerFirstName"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Etternavn/text()))" name="var:CustomerLastName"/>

            <xsl:variable select="userCSharp:CombinedName($var:CustomerFirstName, $var:CustomerLastName)" name="var:CustomerName"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FNr_OrgNr/text()))" name="var:CompanyNo"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Adresse/AdresseLinje[1]/text()))" name="var:StreetAddress1"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Adresse/AdresseLinje[2]/text()))" name="var:StreetAddress2"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Adresse/PostNummer/text()))" name="var:ZipCode1"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Adresse/PostSted/text()))" name="var:Place"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/Adresse/Land/text()))" name="var:Country"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FaktureringsAdresse/AdresseLinje[1]/text()))" name="var:InvoiceStreetAddress1"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FaktureringsAdresse/AdresseLinje[2]/text()))" name="var:InvoiceStreetAddress2"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FaktureringsAdresse/PostNummer/text()))" name="var:InvoiceZipCode2"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FaktureringsAdresse/PostSted/text()))" name="var:InvoiceCity2"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaMottaker/FaktureringsAdresse/Land/text()))" name="var:InvoiceCountry2"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../DeresRef/text()))" name="var:YourRef"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../RessursNummer/text()))" name="var:OurRefTmp"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../Gbnr/text()))" name="var:Contract"/>
            <xsl:variable select="userCSharp:StripCRLF(userCSharp:Substring($var:Product,0,2))" name="var:ServiceType"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaBeskrivelse/ToppTekst/text()))" name="var:HeaderInfo"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaBeskrivelse/BunnTekst/text()))" name="var:FooterInfo"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaBeskrivelse/ToppTekstMal/text()))" name="var:HeaderTextTmp"/>
            <xsl:variable select="userCSharp:StripCRLF(string(../../FakturaBeskrivelse/BunnTekstMal/text()))" name="var:FooterTextTmp"/>
            
            
            <EntityCode><xsl:value-of select="$var:EntityCode" /></EntityCode>
            <ImportingSystem><xsl:value-of select="$var:ImportingSystem" /></ImportingSystem>
            <OrderNo><xsl:value-of select="$var:OrderNo" /></OrderNo>
            <LineNo><xsl:value-of select="$var:LineNo" /></LineNo>
            <Date><xsl:value-of select="$var:Date" /></Date>
            <ReadyToInvoice>1</ReadyToInvoice>
            <Currency>NOK</Currency>
            <Product><xsl:value-of select="$var:Product" /></Product>
            <TextImp><xsl:value-of select="$var:TextImp" /></TextImp>
            <Quantity><xsl:value-of select="$var:Quantity" /></Quantity>
            <UnitPrice><xsl:value-of select="$var:UnitPrice" /></UnitPrice>
            <Customername><xsl:value-of select="$var:CustomerName" /></Customername>
            <CompanyNo><xsl:value-of select="$var:CompanyNo" /></CompanyNo>

            <xsl:choose>
              <xsl:when test="$var:numberOfAddressLines = 1">
                <StreetAddress1><xsl:value-of select="$var:StreetAddress1"/></StreetAddress1>
              </xsl:when>
              <xsl:when test="$var:numberOfAddressLines >= 2">
                <StreetAddress1><xsl:value-of select="$var:StreetAddress1"/></StreetAddress1>
                <StreetAddress2><xsl:value-of select="$var:StreetAddress2"/></StreetAddress2>
              </xsl:when>
            </xsl:choose>

            <ZipCode1><xsl:value-of select="$var:ZipCode1" /></ZipCode1>
            <Place><xsl:value-of select="$var:Place" /></Place>

            <xsl:choose>
              <xsl:when test="$var:Country">
                <Country><xsl:value-of select="$var:Country" /></Country>
              </xsl:when>
              <xsl:otherwise>
                <Country>NO</Country>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
              <xsl:when test="$var:NumberOfInvoiceAddressLines = 1">
                <InvoiceStreetAddress1><xsl:value-of select="$var:InvoiceStreetAddress1"/></InvoiceStreetAddress1>
              </xsl:when>
              <xsl:when test="$var:NumberOfInvoiceAddressLines >= 2">
                <InvoiceStreetAddress1><xsl:value-of select="$var:InvoiceStreetAddress1"/></InvoiceStreetAddress1>
                <InvoiceStreetAddress2><xsl:value-of select="$var:InvoiceStreetAddress2"/></InvoiceStreetAddress2>
              </xsl:when>
            </xsl:choose>
            <InvoiceZipCode2><xsl:value-of select="$var:InvoiceZipCode2" /></InvoiceZipCode2>
            <InvoiceCity2><xsl:value-of select="$var:InvoiceCity2" /></InvoiceCity2>

            <xsl:choose>
              <xsl:when test="$var:InvoiceCountry2">
                <InvoiceCountry2><xsl:value-of select="$var:InvoiceCountry2" /></InvoiceCountry2>
              </xsl:when>
              <xsl:otherwise>
                <InvoiceCountry2>NO</InvoiceCountry2>
              </xsl:otherwise>
            </xsl:choose>

            <YourRef><xsl:value-of select="$var:YourRef" /></YourRef>
            <OurRefTmp><xsl:value-of select="$var:OurRefTmp" /></OurRefTmp>
            <Contract><xsl:value-of select="$var:Contract" /></Contract>
            <ServiceType><xsl:value-of select="$var:ServiceType" /></ServiceType>
            <HeaderInfo><xsl:value-of select="$var:HeaderInfo" /></HeaderInfo>
            <FooterInfo><xsl:value-of select="$var:FooterInfo" /></FooterInfo>
            <HeaderTextTmp><xsl:value-of select="$var:HeaderTextTmp" /></HeaderTextTmp>
            <FooterTextTmp><xsl:value-of select="$var:FooterTextTmp" /></FooterTextTmp>
            <EOL>X</EOL>
          </SO01bRecord>
        </xsl:for-each>
      </xsl:for-each>
    </ns0:SO01b>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[

public string FormatWithLeadingZeroes(int value)
{
	return value.ToString("D4");
}

public string FormatDate(DateTime dt, string format)
{
    return dt.ToString(format);
}

public string StripCRLF(string s)
{
    var s1=s.Trim();
    return s1.Replace("\r\n", "");
}

public string Substring(string s, int strart, int length)
{
    return s.Substring(strart, length);
}

public string CombinedName(string firstName, string lastName)
{
    return System.String.Concat(lastName.ToUpper()," ",firstName.ToUpper());
}

]]>
  </msxsl:script>

</xsl:stylesheet>