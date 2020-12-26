if(NOT CANlib_FOUND)
    message(FATAL_ERROR "'Duet3' build requires CANlib")
endif()

add_definitions("-D__SAME70Q20B__" "-DDUET3_V06" "-DHAS_LINUX_INTERFACE" "-DUSE_CAN0")

add_compile_options("-mcpu=cortex-m7" "-mfpu=fpv5-d16" "-mfloat-abi=hard")
add_link_options("-mcpu=cortex-m7" "-mfpu=fpv5-d16" "-mfloat-abi=hard")

list(APPEND SRCS
    "${CMAKE_CURRENT_LIST_DIR}/Pins_Duet3_V06.cpp"

    "${CMAKE_CURRENT_SOURCE_DIR}/src/Linux/LinuxInterface.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Linux/DataTransfer.cpp"

    "${CMAKE_SOURCE_DIR}/src/Hardware/SAME70/Ethernet/GmacInterface.cpp"
    "${CMAKE_SOURCE_DIR}/src/Hardware/SAME70/Ethernet/ksz8081rna/ethernet_phy.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/LwipEthernetInterface.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/LwipSocket.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/GMAC/ethernet_sam.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/altcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/altcp_alloc.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/http/altcp_proxyconnect.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/altcp_tcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/api_lib.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/api_msg.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/polarssl/arc4.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/auth.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/autoip.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/bridgeif.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/bridgeif_fdb.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/ccp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/chap-md5.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/chap_ms.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/chap-new.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/def.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/demand.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/polarssl/des.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/dhcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/dhcp6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/dns.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/eap.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/ecp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/err.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/etharp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ethernet.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/ethip6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/eui64.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/http/fs.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/fsm.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/http/http_client.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/http/httpd.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/icmp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/icmp6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/if_api.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/igmp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/inet6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/inet_chksum.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/init.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ip.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/ip4.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/ip4_addr.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv4/ip4_frag.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/ip6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/ip6_addr.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/ip6_frag.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/ipcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/ipv6cp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/lcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/lowpan6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/lowpan6_ble.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/lowpan6_common.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/lwiperf/lwiperf.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/magic.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/polarssl/md4.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/polarssl/md5.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/mdns/mdns.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/mem.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/memp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/mld6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/mppe.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/mqtt/mqtt.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/multilink.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/ipv6/nd6.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/netbiosns/netbiosns.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/netbuf.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/netdb.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/netif.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/netifapi.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/pbuf.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/ppp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/pppapi.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/pppcrypt.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/pppoe.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/pppol2tp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/pppos.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/raw.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/polarssl/sha1.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/slipif.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/smtp/smtp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_asn1.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_core.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_icmp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_interfaces.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_ip.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_snmp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_system.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_tcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_mib2_udp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_msg.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_netconn.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_pbuf_stream.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_raw.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_scalar.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_snmpv2_framework.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_snmpv2_usm.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_table.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_threadsync.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmp_traps.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmpv3.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/snmp/snmpv3_mbedtls.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/sntp/sntp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/sockets.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/stats.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/sys.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/tcp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/tcp_in.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/api/tcpip.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/tcp_out.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/apps/tftp/tftp_server.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/timeouts.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/core/udp.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/upap.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/utils.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/ppp/vj.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/netif/zepif.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Hardware/SAME70/CanDriver.cpp"

    "${CANlib_DIR}/src/CanMessageBuffer.cpp"
    "${CANlib_DIR}/src/CanMessageFormats.cpp"
    "${CANlib_DIR}/src/CanSettings.cpp"
)

list(APPEND INCLUDE_DIRS 
    "${CMAKE_CURRENT_LIST_DIR}"
    "${CANlib_DIR}/src"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Hardware/SAME70"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip/src/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Networking/LwipEthernet/Lwip"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Hardware/SAME70/Ethernet"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Hardware/SAME70"
)

set(EXECUTABLE_NAME "Duet3Firmware_MB6HC")