# $FreeBSD$

PORTNAME=	seafdav
DISTVERSIONPREFIX=	v
DISTVERSION=	${SEAHUB_VER}
DISTVERSIONSUFFIX=	-pro
CATEGORIES=	www python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ultima@FreeBSD.org
COMMENT=	Python library for accessing seafile data model

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}defusedxml>=0.5:devel/py-defusedxml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}Jinja2>=2.10:devel/py-Jinja2@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}jsmin>=2.2:devel/py-jsmin@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}python-pam>=1.8:security/py-python-pam@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}yaml>=1.8:devel/py-yaml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}six>=1.12:devel/py-six@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}lxml>=0:devel/py-lxml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}sqlalchemy13>=0:databases/py-sqlalchemy13@${PY_FLAVOR}

USES=		python:2.7 shebangfix
USE_GITHUB=	yes
GH_ACCOUNT=	haiwen
USE_PYTHON=	flavors
SHEBANG_FILES=	*.sh *.template wsgidav/addons/seafile/*.py

NO_ARCH=	yes
NO_BUILD=	yes

do-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/${SITEPACKAGEDIR}/wsgidav
	(cd ${WRKSRC}/wsgidav && \
		${PYTHON_CMD} ${PYTHON_LIBDIR}/compileall.py \
			-d ${WRKSRC}/wsgidav \
			-f ${WRKSRC}/wsgidav && \
		${PYTHON_CMD} -O ${PYTHON_LIBDIR}/compileall.py \
			-d ${WRKSRC}/wsgidav \
			-f ${WRKSRC}/wsgidav)
	(cd ${WRKSRC}/wsgidav && \
		${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/${SITEPACKAGEDIR}/wsgidav)

.include "${.CURDIR}/../../net-mgmt/seafile-server/Makefile.include"

.include <bsd.port.mk>
