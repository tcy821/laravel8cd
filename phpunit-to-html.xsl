<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Match the root element -->
    <xsl:template match="/">
        <html>
            <head>
                <title>PHPUnit Test Report</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                    }
                    th {
                        background-color: #f4f4f4;
                    }
                    tr:nth-child(even) {
                        background-color: #f9f9f9;
                    }
                </style>
            </head>
            <body>
                <h1>PHPUnit Test Report</h1>
                <table>
                    <tr>
                        <th>Test Suite</th>
                        <th>Test Case</th>
                        <th>Status</th>
                    </tr>
                    <!-- Iterate over each test suite -->
                    <xsl:for-each select="//testsuite">
                        <!-- Iterate over each test case within the test suite -->
                        <xsl:for-each select="testsuite/testcase">
                            <tr>
                                <!-- Display the test suite name -->
                                <td><xsl:value-of select="../@name"/></td>
                                <!-- Display the test case name -->
                                <td><xsl:value-of select="@name"/></td>
                                <!-- Determine the status of the test case -->
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="failure">Failed</xsl:when>
                                        <xsl:otherwise>Passed</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
