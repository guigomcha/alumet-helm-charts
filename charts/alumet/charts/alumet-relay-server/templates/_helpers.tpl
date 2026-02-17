{{/*
Expand the name of the chart.
*/}}
{{- define "alumet-relay-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alumet-relay-server.fullname" -}}
  {{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alumet-relay-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alumet-relay-server.labels" -}}
helm.sh/chart: {{ include "alumet-relay-server.chart" . }}
{{ include "alumet-relay-server.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.version | default (printf "%s-%.f" .Chart.AppVersion .Values.image.revision) | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alumet-relay-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alumet-relay-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
