echo '------------------------------'
echo '=====>deploy szirine-api<====='
echo '------------------------------'


echo '=====>delete sz-dev-ns'
kubectl delete -n sz-dev-ns
echo '=====>create sz-dev-ns'
kubectl create -f ./k8s/templates/dev-namespace.yaml

echo '=====>delete szirine-api-configmap'
kubectl delete configmap -n sz-dev-ns szirine-api-configmap
echo '=====>create szirine-api-configmap'
kubectl create -f ./k8s/templates/dev-configmap.yaml


echo '=====>delete szirine-api-deployment<====='
kubectl delete deployment -n sz-dev-ns szirine-api-deployment
# while resource still exists wait
rc=$(eval 'kubectl get deployment -n sz-dev-ns szirine-api-deployment')
while [ ! -z "$rc" ] 
do
    rc=$(eval 'kubectl get deployment -n sz-dev-ns szirine-api-deployment')
done
echo '=====>create szirine-api-deployment<====='
kubectl create -f ./k8s/templates/dev-deployment.yaml


echo '=====>delete szirine-api-svc<====='
kubectl delete svc -n sz-dev-ns szirine-api-svc
# while resource still exists wait
rc=$(eval 'kubectl get svc -n sz-dev-ns szirine-api-svc')
while [ ! -z "$rc" ] 
do
    rc=$(eval 'kubectl get svc -n sz-dev-ns szirine-api-svc')
done
echo '=====>create szirine-api-svc<====='
kubectl create -f ./k8s/templates/dev-svc.yaml


echo '=====>delete szirine-api-hpa<====='
kubectl delete hpa -n sz-dev-ns szirine-api-hpa
# while resource still exists wait
rc=$(eval 'kubectl get svc -n sz-dev-ns szirine-api-hpa')
while [ ! -z "$rc" ] 
do
    rc=$(eval 'kubectl get svc -n sz-dev-ns szirine-api-hpa')
done
echo '=====>create szirine-api-hpa<====='
kubectl create -f ./k8s/templates/dev-hpa.yaml


echo '--------------------------------'
echo '=====>szirine-api deployed<====='
echo '--------------------------------'
