# Created by: Nakata Maho <maho@FreeBSD.org>
# $FreeBSD$

PORTNAME=	qd
DISTVERSION=	2.3.22
CATEGORIES=	math
MASTER_SITES=	http://crd-legacy.lbl.gov/~dhbailey/mpdist/

MAINTAINER=	fortran@FreeBSD.org
COMMENT=	Double-Double and Quad-Double Arithmetic

LICENSE=	BSD3CLAUSE
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		fortran libtool
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-shared --disable-static
USE_LDCONFIG=	yes

OPTIONS_DEFINE=	DOCS

.include <bsd.port.mk>
